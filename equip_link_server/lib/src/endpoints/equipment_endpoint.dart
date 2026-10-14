import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../auth/student_eligibility_guard.dart';
import '../generated/protocol.dart';

/// Endpoint for equipment categories, discovery, listings, and availability checks.
class EquipmentEndpoint extends Endpoint {
  /// Fetches equipment categories, seeding defaults if the table is empty.
  Future<List<EquipmentCategory>> getCategories(Session session) async {
    var categories = await EquipmentCategory.db.find(
      session,
      orderBy: (t) => t.name,
    );

    if (categories.isEmpty) {
      final defaultCategories = [
        EquipmentCategory(
          name: 'Cameras & Video',
          slug: 'cameras-video',
          description: 'DSLRs, mirrorless cameras, lenses, and gimbals',
          iconName: 'camera_alt_rounded',
          isActive: true,
        ),
        EquipmentCategory(
          name: 'Audio & Microphones',
          slug: 'audio-mics',
          description: 'Podcasting mics, audio interfaces, and headphones',
          iconName: 'mic_rounded',
          isActive: true,
        ),
        EquipmentCategory(
          name: 'Laptops & Computing',
          slug: 'laptops-computing',
          description:
              'High-performance laptops, monitors, and drawing tablets',
          iconName: 'laptop_rounded',
          isActive: true,
        ),
        EquipmentCategory(
          name: 'Lab & STEM Equipment',
          slug: 'lab-stem',
          description:
              'Oscilloscopes, soldering kits, and 3D printer accessories',
          iconName: 'science_rounded',
          isActive: true,
        ),
        EquipmentCategory(
          name: 'Sports & Outdoors',
          slug: 'sports-outdoors',
          description: 'Camping gear, bikes, and recreation equipment',
          iconName: 'sports_basketball_rounded',
          isActive: true,
        ),
      ];

      for (final cat in defaultCategories) {
        await EquipmentCategory.db.insertRow(session, cat);
      }

      categories = await EquipmentCategory.db.find(
        session,
        orderBy: (t) => t.name,
      );
    }

    return categories;
  }

  /// Checks whether an equipment item is available for rental between [startDate] and [endDate].
  Future<AvailabilityResult> checkAvailability(
    Session session, {
    required int listingId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (!startDate.isBefore(endDate)) {
      return AvailabilityResult(
        listingId: listingId,
        isAvailable: false,
        conflictingRentalsCount: 0,
        message: 'End date must be after start date.',
      );
    }

    final listing = await EquipmentListing.db.findById(session, listingId);
    if (listing == null) {
      return AvailabilityResult(
        listingId: listingId,
        isAvailable: false,
        conflictingRentalsCount: 0,
        message: 'Equipment listing not found.',
      );
    }

    if (listing.status != 'available') {
      return AvailabilityResult(
        listingId: listingId,
        isAvailable: false,
        conflictingRentalsCount: 0,
        message: 'Equipment is currently in ${listing.status} status.',
      );
    }

    // Check for overlapping approved or in_progress rentals
    final activeRentals = await RentalRequest.db.find(
      session,
      where: (t) =>
          (t.listingId.equals(listingId)) &
          ((t.status.equals('approved')) | (t.status.equals('in_progress'))) &
          (t.startDate < endDate) &
          (t.endDate > startDate),
    );

    if (activeRentals.isNotEmpty) {
      return AvailabilityResult(
        listingId: listingId,
        isAvailable: false,
        conflictingRentalsCount: activeRentals.length,
        message: 'Selected dates overlap with an existing approved rental.',
      );
    }

    return AvailabilityResult(
      listingId: listingId,
      isAvailable: true,
      conflictingRentalsCount: 0,
      message: 'Item is available for the requested rental window.',
    );
  }

  /// Creates a new equipment listing. Requires authenticated user.
  Future<EquipmentListing> createListing(
    Session session, {
    required int categoryId,
    required String title,
    required String description,
    required double dailyRate,
    required double securityDeposit,
    required String condition,
    required String locationCampus,
    double? hourlyRate,
    List<String> imageUrls = const [],
  }) async {
    await requireEligibleStudent(session);
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw EquipLinkException(
        message: 'Authentication required to create a listing.',
        statusCode: 401,
      );
    }

    if (dailyRate <= 0) {
      throw EquipLinkException(
        message: 'Daily rate must be greater than zero.',
        statusCode: 400,
      );
    }

    if (securityDeposit < 0) {
      throw EquipLinkException(
        message: 'Security deposit cannot be negative.',
        statusCode: 400,
      );
    }

    final listing = EquipmentListing(
      ownerId: authUserId,
      categoryId: categoryId,
      title: title.trim(),
      description: description.trim(),
      dailyRate: dailyRate,
      hourlyRate: hourlyRate,
      securityDeposit: securityDeposit,
      condition: condition.trim(),
      status: 'available',
      locationCampus: locationCampus.trim(),
      imageUrls: imageUrls,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return await EquipmentListing.db.insertRow(session, listing);
  }

  /// Updates an existing equipment listing. Requires listing ownership.
  Future<EquipmentListing> updateListing(
    Session session,
    EquipmentListing listing,
  ) async {
    await requireEligibleStudent(session);
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw EquipLinkException(
        message: 'Authentication required.',
        statusCode: 401,
      );
    }

    final existing = await EquipmentListing.db.findById(session, listing.id!);
    if (existing == null) {
      throw EquipLinkException(
        message: 'Listing not found.',
        statusCode: 404,
      );
    }

    if (existing.ownerId != authUserId) {
      throw EquipLinkException(
        message: 'Only the listing owner can update this item.',
        statusCode: 403,
      );
    }

    listing.ownerId = authUserId;
    listing.updatedAt = DateTime.now();

    return await EquipmentListing.db.updateRow(session, listing);
  }

  /// Deletes a listing if owned by the user and not currently active in a rental.
  Future<bool> deleteListing(Session session, int listingId) async {
    await requireEligibleStudent(session);
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw EquipLinkException(
        message: 'Authentication required.',
        statusCode: 401,
      );
    }

    final existing = await EquipmentListing.db.findById(session, listingId);
    if (existing == null) {
      throw EquipLinkException(
        message: 'Listing not found.',
        statusCode: 404,
      );
    }

    if (existing.ownerId != authUserId) {
      throw EquipLinkException(
        message: 'Forbidden: you do not own this listing.',
        statusCode: 403,
      );
    }

    final activeRentals = await RentalRequest.db.find(
      session,
      where: (t) =>
          (t.listingId.equals(listingId)) &
          ((t.status.equals('approved')) | (t.status.equals('in_progress'))),
    );

    if (activeRentals.isNotEmpty) {
      throw EquipLinkException(
        message: 'Cannot delete listing with active or approved rentals.',
        statusCode: 400,
      );
    }

    await EquipmentListing.db.deleteRow(session, existing);
    return true;
  }

  /// Fetches an individual listing by ID.
  Future<EquipmentListing?> getListing(Session session, int listingId) async {
    return await EquipmentListing.db.findById(session, listingId);
  }

  /// Searches and filters equipment listings.
  Future<List<EquipmentListing>> searchListings(
    Session session, {
    int? categoryId,
    String? query,
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    final searchStatus = status ?? 'available';

    return await EquipmentListing.db.find(
      session,
      where: (t) {
        var expr = t.status.equals(searchStatus);
        if (categoryId != null) {
          expr = expr & t.categoryId.equals(categoryId);
        }
        if (query != null && query.trim().isNotEmpty) {
          expr = expr & t.title.ilike('%${query.trim()}%');
        }
        return expr;
      },
      limit: limit,
      offset: offset,
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Retrieves listings owned by the authenticated student.
  Future<List<EquipmentListing>> getMyListings(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw EquipLinkException(
        message: 'Authentication required.',
        statusCode: 401,
      );
    }

    return await EquipmentListing.db.find(
      session,
      where: (t) => t.ownerId.equals(authUserId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }
}
