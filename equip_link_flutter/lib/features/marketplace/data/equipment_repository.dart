import 'models/equipment_item.dart';
import '../../../core/widgets/filter_bottom_sheet.dart';

abstract class EquipmentRepository {
  Future<List<EquipmentItem>> getRecentEquipment();
  Future<List<EquipmentItem>> searchEquipment({
    String query = '',
    FilterCriteria? filter,
    String sortBy = 'lowestPrice',
  });
  Future<EquipmentItem?> getEquipmentById(String id);
  Future<List<EquipmentItem>> getMyListings();
  Future<EquipmentItem> saveListing(EquipmentItem item);
  Future<bool> toggleListingAvailability(String id, bool isAvailable);
  Future<bool> deleteListing(String id);
}
