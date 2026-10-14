import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../client.dart';
import '../../../core/widgets/filter_bottom_sheet.dart';
import 'equipment_repository.dart';
import 'models/equipment_item.dart';

class ServerpodEquipmentRepository implements EquipmentRepository {
  @override
  Future<List<EquipmentItem>> getRecentEquipment() {
    return searchEquipment();
  }

  @override
  Future<List<EquipmentItem>> searchEquipment({
    String query = '',
    FilterCriteria? filter,
    String sortBy = 'lowestPrice',
  }) async {
    final listings = await client.equipment.searchListings(
      query: query.trim().isEmpty ? null : query.trim(),
      limit: 100,
      offset: 0,
    );
    final items = listings.map(_toUiItem).where((item) {
      if (filter == null) return true;
      if (filter.categories.isNotEmpty &&
          !filter.categories.contains(item.category)) {
        return false;
      }
      if (filter.conditions.isNotEmpty &&
          !filter.conditions.contains(item.condition)) {
        return false;
      }
      if (item.dailyRate < filter.priceRange.start ||
          item.dailyRate > filter.priceRange.end) {
        return false;
      }
      return !filter.availableToday || item.isAvailable;
    }).toList();
    if (sortBy == 'lowestPrice') {
      items.sort((a, b) => a.dailyRate.compareTo(b.dailyRate));
    } else if (sortBy == 'highestRated') {
      items.sort((a, b) => b.lenderRating.compareTo(a.lenderRating));
    }
    return items;
  }

  @override
  Future<EquipmentItem?> getEquipmentById(String id) async {
    final listingId = int.tryParse(id);
    if (listingId == null) return null;
    final listing = await client.equipment.getListing(listingId);
    return listing == null ? null : _toUiItem(listing);
  }

  @override
  Future<List<EquipmentItem>> getMyListings() async {
    final listings = await client.equipment.getMyListings();
    return listings.map(_toUiItem).toList();
  }

  @override
  Future<EquipmentItem> saveListing(EquipmentItem item) async {
    final existingId = int.tryParse(item.id);
    final listing = existingId == null
        ? await client.equipment.createListing(
            categoryId: int.tryParse(item.category) ?? 1,
            title: item.name,
            description: item.description,
            dailyRate: item.dailyRate,
            securityDeposit: 0,
            condition: item.condition,
            locationCampus: item.campusLocation,
            imageUrls: item.imageUrl.isEmpty ? [] : [item.imageUrl],
          )
        : await client.equipment.updateListing(
            (await client.equipment.getListing(existingId))!.copyWith(
              title: item.name,
              description: item.description,
              dailyRate: item.dailyRate,
              condition: item.condition,
              locationCampus: item.campusLocation,
              imageUrls: item.imageUrl.isEmpty ? [] : [item.imageUrl],
            ),
          );
    return _toUiItem(listing);
  }

  @override
  Future<bool> toggleListingAvailability(String id, bool isAvailable) async {
    final listingId = int.tryParse(id);
    if (listingId == null) return false;
    final listing = await client.equipment.getListing(listingId);
    if (listing == null) return false;
    await client.equipment.updateListing(
      listing.copyWith(status: isAvailable ? 'available' : 'unavailable'),
    );
    return true;
  }

  @override
  Future<bool> deleteListing(String id) {
    final listingId = int.tryParse(id);
    return listingId == null
        ? Future.value(false)
        : client.equipment.deleteListing(listingId);
  }

  EquipmentItem _toUiItem(dynamic listing) {
    return EquipmentItem(
      id: listing.id?.toString() ?? '',
      name: listing.title,
      category: listing.categoryId.toString(),
      condition: listing.condition,
      dailyRate: listing.dailyRate,
      weeklyRate: listing.dailyRate * 7,
      imageUrl: listing.imageUrls.isEmpty ? '' : listing.imageUrls.first,
      campusLocation: listing.locationCampus,
      lenderName: 'Campus student',
      lenderRating: 0,
      reviewsCount: 0,
      isAvailable: listing.status == 'available',
      description: listing.description,
    );
  }
}

final equipmentRepositoryProvider = Provider<EquipmentRepository>((ref) {
  return ServerpodEquipmentRepository();
});

final equipmentListProvider = FutureProvider<List<EquipmentItem>>((ref) {
  return ref.watch(equipmentRepositoryProvider).getRecentEquipment();
});

final equipmentDetailsProvider = FutureProvider.family<EquipmentItem?, String>((
  ref,
  id,
) {
  return ref.watch(equipmentRepositoryProvider).getEquipmentById(id);
});

final myListingsProvider = FutureProvider<List<EquipmentItem>>((ref) {
  return ref.watch(equipmentRepositoryProvider).getMyListings();
});
