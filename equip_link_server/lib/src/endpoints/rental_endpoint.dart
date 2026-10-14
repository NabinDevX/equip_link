import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../auth/student_eligibility_guard.dart';
import '../generated/protocol.dart';

/// Endpoint managing rental lifecycles, transactions, handover, return, and reviews.
class RentalEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Helper to record status change in audit history.
  Future<void> _recordStatusHistory(
    Session session, {
    required int rentalRequestId,
    required String status,
    required UuidValue changedBy,
    String? notes,
    Transaction? transaction,
  }) async {
    final history = RentalStatusHistory(
      rentalRequestId: rentalRequestId,
      status: status,
      changedBy: changedBy,
      notes: notes,
      timestamp: DateTime.now(),
    );
    await RentalStatusHistory.db.insertRow(
      session,
      history,
      transaction: transaction,
    );
  }

  /// Creates a new rental request for an equipment listing.
  ///
  /// Enforces:
  /// 1. Self-renting prevention (owner cannot rent their own item).
  /// 2. Date range validation (end date > start date, start date >= today).
  /// 3. Overlap check against existing approved / in_progress rentals.
  /// 4. Price & security deposit calculation from official listing.
  Future<RentalRequest> createRentalRequest(
    Session session, {
    required int listingId,
    required DateTime startDate,
    required DateTime endDate,
    String? notes,
  }) async {
    await requireEligibleStudent(session);
    final renterId = session.authenticated!.authUserId;

    // 1. Fetch listing
    final listing = await EquipmentListing.db.findById(session, listingId);
    if (listing == null) {
      throw EquipLinkException(
        message: 'Equipment listing not found.',
        statusCode: 404,
      );
    }

    if (listing.status != 'available') {
      throw EquipLinkException(
        message:
            'Equipment is not available for rent (status: ${listing.status}).',
        statusCode: 400,
      );
    }

    // 2. Prevent self-renting
    if (listing.ownerId == renterId) {
      throw EquipLinkException(
        message:
            'Cannot rent equipment that you own. Self-renting is prohibited.',
        statusCode: 400,
      );
    }

    // 3. Validate dates
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    if (startDate.isBefore(todayStart)) {
      throw EquipLinkException(
        message: 'Rental start date cannot be in the past.',
        statusCode: 400,
      );
    }

    if (!startDate.isBefore(endDate)) {
      throw EquipLinkException(
        message: 'End date must be after start date.',
        statusCode: 400,
      );
    }

    // 4. Check for overlapping approved rentals
    final conflictingRentals = await RentalRequest.db.find(
      session,
      where: (t) =>
          (t.listingId.equals(listingId)) &
          ((t.status.equals('approved')) | (t.status.equals('in_progress'))) &
          (t.startDate < endDate) &
          (t.endDate > startDate),
    );

    if (conflictingRentals.isNotEmpty) {
      throw EquipLinkException(
        message: 'The selected dates overlap with an existing approved rental.',
        statusCode: 409,
      );
    }

    // 5. Calculate durations and totals
    final days = max(1, endDate.difference(startDate).inDays);
    final totalAmount = days * listing.dailyRate;

    final request = RentalRequest(
      listingId: listingId,
      renterId: renterId,
      ownerId: listing.ownerId,
      startDate: startDate,
      endDate: endDate,
      totalDays: days,
      dailyRate: listing.dailyRate,
      totalAmount: totalAmount,
      securityDeposit: listing.securityDeposit,
      status: 'pending',
      notes: notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await session.db.transaction((tx) async {
      final inserted = await RentalRequest.db.insertRow(
        session,
        request,
        transaction: tx,
      );
      await _recordStatusHistory(
        session,
        rentalRequestId: inserted.id!,
        status: 'pending',
        changedBy: renterId,
        notes: 'Rental request created by renter.',
        transaction: tx,
      );
      return inserted;
    });
  }

  /// Approves a pending rental request. Only the equipment owner may approve.
  Future<RentalRequest> approveRentalRequest(
    Session session,
    int requestId,
  ) async {
    await requireEligibleStudent(session);
    final currentUserId = session.authenticated!.authUserId;

    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.ownerId != currentUserId) {
      throw EquipLinkException(
        message:
            'Forbidden: only the equipment owner can approve this request.',
        statusCode: 403,
      );
    }

    if (request.status != 'pending') {
      throw EquipLinkException(
        message: 'Cannot approve a request with status "${request.status}".',
        statusCode: 400,
      );
    }

    return await session.db.transaction((tx) async {
      // Re-verify no conflicts within the transaction
      final conflicts = await RentalRequest.db.find(
        session,
        where: (t) =>
            (t.listingId.equals(request.listingId)) &
            (t.id.notEquals(request.id!)) &
            ((t.status.equals('approved')) | (t.status.equals('in_progress'))) &
            (t.startDate < request.endDate) &
            (t.endDate > request.startDate),
        transaction: tx,
      );

      if (conflicts.isNotEmpty) {
        throw EquipLinkException(
          message:
              'Conflict: another booking was already approved for overlapping dates.',
          statusCode: 409,
        );
      }

      request.status = 'approved';
      request.updatedAt = DateTime.now();
      final updated = await RentalRequest.db.updateRow(
        session,
        request,
        transaction: tx,
      );

      await _recordStatusHistory(
        session,
        rentalRequestId: updated.id!,
        status: 'approved',
        changedBy: currentUserId,
        notes: 'Owner approved the rental request.',
        transaction: tx,
      );

      return updated;
    });
  }

  /// Rejects a pending rental request. Only the equipment owner may reject.
  Future<RentalRequest> rejectRentalRequest(
    Session session,
    int requestId, {
    String? reason,
  }) async {
    await requireEligibleStudent(session);
    final currentUserId = session.authenticated!.authUserId;

    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.ownerId != currentUserId) {
      throw EquipLinkException(
        message: 'Only the owner can reject this rental request.',
        statusCode: 403,
      );
    }

    if (request.status != 'pending') {
      throw EquipLinkException(
        message: 'Only pending requests can be rejected.',
        statusCode: 400,
      );
    }

    request.status = 'rejected';
    request.updatedAt = DateTime.now();

    return await session.db.transaction((tx) async {
      final updated = await RentalRequest.db.updateRow(
        session,
        request,
        transaction: tx,
      );
      await _recordStatusHistory(
        session,
        rentalRequestId: updated.id!,
        status: 'rejected',
        changedBy: currentUserId,
        notes: reason ?? 'Owner rejected request.',
        transaction: tx,
      );
      return updated;
    });
  }

  /// Cancels a rental request before handover. Renter or owner may cancel.
  Future<RentalRequest> cancelRentalRequest(
    Session session,
    int requestId, {
    String? reason,
  }) async {
    await requireEligibleStudent(session);
    final currentUserId = session.authenticated!.authUserId;

    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.renterId != currentUserId && request.ownerId != currentUserId) {
      throw EquipLinkException(
        message: 'Forbidden: you are not a party to this rental.',
        statusCode: 403,
      );
    }

    if (request.status != 'pending' && request.status != 'approved') {
      throw EquipLinkException(
        message: 'Cannot cancel rental once in progress or completed.',
        statusCode: 400,
      );
    }

    request.status = 'cancelled';
    request.updatedAt = DateTime.now();

    return await session.db.transaction((tx) async {
      final updated = await RentalRequest.db.updateRow(
        session,
        request,
        transaction: tx,
      );
      await _recordStatusHistory(
        session,
        rentalRequestId: updated.id!,
        status: 'cancelled',
        changedBy: currentUserId,
        notes: reason ?? 'Rental cancelled.',
        transaction: tx,
      );
      return updated;
    });
  }

  /// Confirms equipment handover, transitioning rental to 'in_progress'.
  Future<RentalRequest> confirmHandover(
    Session session, {
    required int requestId,
    String? conditionNotes,
  }) async {
    await requireEligibleStudent(session);
    final currentUserId = session.authenticated!.authUserId;

    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.ownerId != currentUserId && request.renterId != currentUserId) {
      throw EquipLinkException(
        message: 'Forbidden: not a party to this rental.',
        statusCode: 403,
      );
    }

    if (request.status != 'approved') {
      throw EquipLinkException(
        message: 'Handover requires an approved rental request.',
        statusCode: 400,
      );
    }

    return await session.db.transaction((tx) async {
      final isOwner = request.ownerId == currentUserId;

      final confirmation = HandoverConfirmation(
        rentalRequestId: requestId,
        type: 'handover',
        confirmedByOwner: isOwner,
        confirmedByRenter: !isOwner,
        itemConditionNotes: conditionNotes,
        confirmedAt: DateTime.now(),
        createdAt: DateTime.now(),
      );
      await HandoverConfirmation.db.insertRow(
        session,
        confirmation,
        transaction: tx,
      );

      request.status = 'in_progress';
      request.updatedAt = DateTime.now();
      final updated = await RentalRequest.db.updateRow(
        session,
        request,
        transaction: tx,
      );

      await _recordStatusHistory(
        session,
        rentalRequestId: updated.id!,
        status: 'in_progress',
        changedBy: currentUserId,
        notes: 'Handover confirmed. Rental in progress.',
        transaction: tx,
      );

      return updated;
    });
  }

  /// Confirms equipment return, marking rental 'completed'.
  Future<RentalRequest> confirmReturn(
    Session session, {
    required int requestId,
    String? returnNotes,
  }) async {
    await requireEligibleStudent(session);
    final currentUserId = session.authenticated!.authUserId;

    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.ownerId != currentUserId && request.renterId != currentUserId) {
      throw EquipLinkException(
        message: 'Forbidden: not a party to this rental.',
        statusCode: 403,
      );
    }

    if (request.status != 'in_progress') {
      throw EquipLinkException(
        message: 'Return requires an in-progress rental.',
        statusCode: 400,
      );
    }

    return await session.db.transaction((tx) async {
      final isOwner = request.ownerId == currentUserId;

      final confirmation = HandoverConfirmation(
        rentalRequestId: requestId,
        type: 'return',
        confirmedByOwner: isOwner,
        confirmedByRenter: !isOwner,
        itemConditionNotes: returnNotes,
        confirmedAt: DateTime.now(),
        createdAt: DateTime.now(),
      );
      await HandoverConfirmation.db.insertRow(
        session,
        confirmation,
        transaction: tx,
      );

      request.status = 'completed';
      request.updatedAt = DateTime.now();
      final updated = await RentalRequest.db.updateRow(
        session,
        request,
        transaction: tx,
      );

      await _recordStatusHistory(
        session,
        rentalRequestId: updated.id!,
        status: 'completed',
        changedBy: currentUserId,
        notes: 'Return confirmed. Rental completed.',
        transaction: tx,
      );

      return updated;
    });
  }

  /// Submits a review and rating (1 to 5) for a completed rental.
  Future<RentalReview> createReview(
    Session session, {
    required int requestId,
    required int rating,
    String? comment,
  }) async {
    await requireEligibleStudent(session);
    final currentUserId = session.authenticated!.authUserId;

    if (rating < 1 || rating > 5) {
      throw EquipLinkException(
        message: 'Rating must be between 1 and 5.',
        statusCode: 400,
      );
    }

    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.status != 'completed') {
      throw EquipLinkException(
        message: 'Reviews can only be submitted for completed rentals.',
        statusCode: 400,
      );
    }

    if (request.renterId != currentUserId && request.ownerId != currentUserId) {
      throw EquipLinkException(
        message: 'Forbidden: not a participant in this rental.',
        statusCode: 403,
      );
    }

    final revieweeId = request.renterId == currentUserId
        ? request.ownerId
        : request.renterId;

    final existing = await RentalReview.db.find(
      session,
      where: (t) =>
          (t.rentalRequestId.equals(requestId)) &
          (t.reviewerId.equals(currentUserId)),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      throw EquipLinkException(
        message: 'You have already submitted a review for this rental.',
        statusCode: 400,
      );
    }

    final review = RentalReview(
      rentalRequestId: requestId,
      reviewerId: currentUserId,
      revieweeId: revieweeId,
      listingId: request.listingId,
      rating: rating,
      comment: comment?.trim(),
      createdAt: DateTime.now(),
    );

    return await RentalReview.db.insertRow(session, review);
  }

  /// Lists rentals requested by the authenticated student.
  Future<List<RentalRequest>> getMyRentalsAsRenter(Session session) async {
    final currentUserId = session.authenticated!.authUserId;
    return await RentalRequest.db.find(
      session,
      where: (t) => t.renterId.equals(currentUserId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Lists rentals received by the owner for their listings.
  Future<List<RentalRequest>> getMyRentalsAsOwner(Session session) async {
    final currentUserId = session.authenticated!.authUserId;
    return await RentalRequest.db.find(
      session,
      where: (t) => t.ownerId.equals(currentUserId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Fetches the status history log of a rental request.
  Future<List<RentalStatusHistory>> getRentalHistory(
    Session session,
    int requestId,
  ) async {
    final currentUserId = session.authenticated!.authUserId;
    final request = await RentalRequest.db.findById(session, requestId);
    if (request == null) {
      throw EquipLinkException(
        message: 'Rental request not found.',
        statusCode: 404,
      );
    }

    if (request.renterId != currentUserId && request.ownerId != currentUserId) {
      throw EquipLinkException(
        message: 'Forbidden: you do not have permission to view history.',
        statusCode: 403,
      );
    }

    return await RentalStatusHistory.db.find(
      session,
      where: (t) => t.rentalRequestId.equals(requestId),
      orderBy: (t) => t.timestamp,
    );
  }
}
