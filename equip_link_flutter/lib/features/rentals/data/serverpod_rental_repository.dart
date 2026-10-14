import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../client.dart';
import 'models/rental_request.dart';
import 'rental_repository.dart';

class ServerpodRentalRepository implements RentalRepository {
  @override
  Future<List<RentalRequest>> getBorrowerRentals({RentalStatus? status}) async {
    final rentals = await client.rental.getMyRentalsAsRenter();
    return _mapAndFilter(rentals, status);
  }

  @override
  Future<List<RentalRequest>> getLenderRentals({RentalStatus? status}) async {
    final rentals = await client.rental.getMyRentalsAsOwner();
    return _mapAndFilter(rentals, status);
  }

  @override
  Future<RentalRequest?> getRentalById(String id) async {
    final requestId = int.tryParse(id);
    if (requestId == null) return null;
    final rentals = await client.rental.getMyRentalsAsRenter();
    final ownerRentals = await client.rental.getMyRentalsAsOwner();
    for (final rental in [...rentals, ...ownerRentals]) {
      if (rental.id == requestId) return _toUiRental(rental);
    }
    return null;
  }

  @override
  Future<RentalRequest> createRentalRequest(RentalRequest request) async {
    final created = await client.rental.createRentalRequest(
      listingId: int.parse(request.equipmentId),
      startDate: request.startDate,
      endDate: request.endDate,
      notes: request.note,
    );
    return _toUiRental(created);
  }

  @override
  Future<bool> updateRentalStatus(String id, RentalStatus newStatus) async {
    final requestId = int.tryParse(id);
    if (requestId == null) return false;
    switch (newStatus) {
      case RentalStatus.approved:
        await client.rental.approveRentalRequest(requestId);
      case RentalStatus.rejected:
        await client.rental.rejectRentalRequest(requestId);
      case RentalStatus.cancelled:
        await client.rental.cancelRentalRequest(requestId);
      case RentalStatus.active:
        await client.rental.confirmHandover(requestId: requestId);
      case RentalStatus.completed:
        await client.rental.confirmReturn(requestId: requestId);
      case RentalStatus.pending:
      case RentalStatus.returnDue:
        return false;
    }
    return true;
  }

  @override
  Future<bool> requestExtension(String id, DateTime newEndDate) {
    return Future.value(false);
  }

  @override
  Future<bool> toggleAccessoryCheck(
    String id,
    String accessory,
    bool isChecked,
  ) {
    return Future.value(false);
  }

  List<RentalRequest> _mapAndFilter(
    Iterable<dynamic> rentals,
    RentalStatus? status,
  ) {
    final mapped = rentals.map(_toUiRental).toList();
    return status == null
        ? mapped
        : mapped.where((rental) => rental.status == status).toList();
  }

  RentalRequest _toUiRental(dynamic rental) {
    final status = RentalStatus.values.firstWhere(
      (value) => value.name == rental.status,
      orElse: () => RentalStatus.pending,
    );
    return RentalRequest(
      id: rental.id?.toString() ?? '',
      equipmentId: rental.listingId.toString(),
      equipmentName: 'Equipment listing #${rental.listingId}',
      equipmentCategory: '',
      equipmentImageUrl: '',
      dailyRate: rental.dailyRate,
      borrowerName: 'Borrower',
      borrowerUniversity: '',
      lenderName: 'Lender',
      lenderUniversity: '',
      startDate: rental.startDate,
      endDate: rental.endDate,
      handoffMethod: HandoffMethod.inPerson,
      campusLocation: '',
      note: rental.notes,
      baseAmount: rental.totalAmount,
      discountAmount: 0,
      serviceFee: 0,
      totalAmount: rental.totalAmount,
      status: status,
      createdAt: rental.createdAt,
    );
  }
}

final rentalRepositoryProvider = Provider<RentalRepository>((ref) {
  return ServerpodRentalRepository();
});

final borrowerRentalsProvider = FutureProvider.autoDispose<List<RentalRequest>>(
  (ref) {
    return ref.watch(rentalRepositoryProvider).getBorrowerRentals();
  },
);

final lenderRentalsProvider = FutureProvider.autoDispose<List<RentalRequest>>((
  ref,
) {
  return ref.watch(rentalRepositoryProvider).getLenderRentals();
});

final rentalDetailsProvider = FutureProvider.autoDispose
    .family<RentalRequest?, String>((ref, id) {
      return ref.watch(rentalRepositoryProvider).getRentalById(id);
    });
