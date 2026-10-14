import 'models/rental_request.dart';

abstract class RentalRepository {
  Future<List<RentalRequest>> getBorrowerRentals({RentalStatus? status});
  Future<List<RentalRequest>> getLenderRentals({RentalStatus? status});
  Future<RentalRequest?> getRentalById(String id);
  Future<RentalRequest> createRentalRequest(RentalRequest request);
  Future<bool> updateRentalStatus(String id, RentalStatus newStatus);
  Future<bool> requestExtension(String id, DateTime newEndDate);
  Future<bool> toggleAccessoryCheck(
    String id,
    String accessory,
    bool isChecked,
  );
}
