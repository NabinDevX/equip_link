import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/rental_request.dart';
import 'rental_repository.dart';

class MockRentalRepository implements RentalRepository {
  final List<RentalRequest> _rentals = [
    RentalRequest(
      id: 'EQ-8841',
      equipmentId: 'fluke-117-multimeter',
      equipmentName: 'Fluke 117 True RMS Digital Multimeter Kit',
      equipmentCategory: 'Electronics & STEM',
      equipmentImageUrl:
          'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=800',
      dailyRate: 6.0,
      borrowerName: 'Alex Rivera',
      borrowerUniversity: 'Stanford University',
      lenderName: 'Marcus Thorne',
      lenderUniversity: 'Stanford University (EE Dept)',
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 2)),
      handoffMethod: HandoffMethod.smartLocker,
      campusLocation: 'Packard EE Bldg - Smart Locker 14B',
      lockerPin: '8492',
      note: 'Need for EE101 lab practical experiment tomorrow.',
      baseAmount: 24.0,
      discountAmount: 4.0,
      serviceFee: 1.5,
      totalAmount: 21.5,
      status: RentalStatus.active,
      accessoriesChecklist: {
        'TL75 test lead pair': true,
        '9V battery installed': true,
        'TPAK magnetic strap': true,
        'Protective holster': false,
      },
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    RentalRequest(
      id: 'EQ-9022',
      equipmentId: 'ti-84-plus-ce',
      equipmentName: 'Texas Instruments TI-84 Plus CE Graphing Calculator',
      equipmentCategory: 'Calculators',
      equipmentImageUrl:
          'https://images.unsplash.com/photo-1594980596870-8aa52a78d8cd?w=800',
      dailyRate: 4.0,
      borrowerName: 'Alex Rivera',
      borrowerUniversity: 'Stanford University',
      lenderName: 'Chloe Bennett',
      lenderUniversity: 'Stanford University (Math)',
      startDate: DateTime.now().add(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 4)),
      handoffMethod: HandoffMethod.inPerson,
      campusLocation: 'Huang Engineering Center Lobby',
      note: 'For MATH 51 midterm review session.',
      baseAmount: 12.0,
      discountAmount: 0.0,
      serviceFee: 1.5,
      totalAmount: 13.5,
      status: RentalStatus.pending,
      accessoriesChecklist: {
        'Slide cover': true,
        'Rechargeable battery': true,
        'USB cable': true,
      },
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
    RentalRequest(
      id: 'EQ-7640',
      equipmentId: 'rigol-ds1054z-oscilloscope',
      equipmentName: 'Rigol DS1054Z 50MHz 4-Channel Digital Oscilloscope',
      equipmentCategory: 'Electronics & STEM',
      equipmentImageUrl:
          'https://images.unsplash.com/photo-1581092335397-9583fe92d232?w=800',
      dailyRate: 12.0,
      borrowerName: 'Sarah Jenkins',
      borrowerUniversity: 'Stanford University (CS)',
      lenderName: 'Alex Rivera',
      lenderUniversity: 'Stanford University',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().subtract(const Duration(days: 1)),
      handoffMethod: HandoffMethod.smartLocker,
      campusLocation: 'Gates CS Hall - Smart Locker 08A',
      lockerPin: '4190',
      baseAmount: 48.0,
      discountAmount: 8.0,
      serviceFee: 1.5,
      totalAmount: 41.5,
      status: RentalStatus.completed,
      accessoriesChecklist: {
        '4x passive probes': true,
        'Power cord': true,
        'USB host cable': true,
      },
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    RentalRequest(
      id: 'EQ-9310',
      equipmentId: 'sony-alpha-a6400',
      equipmentName: 'Sony Alpha a6400 Mirrorless Camera Kit',
      equipmentCategory: 'Media & Cameras',
      equipmentImageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800',
      dailyRate: 18.0,
      borrowerName: 'Jordan Lee',
      borrowerUniversity: 'Stanford University (Comm)',
      lenderName: 'Alex Rivera',
      lenderUniversity: 'Stanford University',
      startDate: DateTime.now().add(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 5)),
      handoffMethod: HandoffMethod.inPerson,
      campusLocation: 'Huang Center Lobby',
      note: 'Filming documentary project for COMM 104.',
      baseAmount: 54.0,
      discountAmount: 6.0,
      serviceFee: 1.5,
      totalAmount: 49.5,
      status: RentalStatus.pending,
      accessoriesChecklist: {
        '16-50mm OSS lens': true,
        '2x batteries': true,
        '64GB SD card': true,
        'Padded carry case': true,
      },
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  @override
  Future<List<RentalRequest>> getBorrowerRentals({RentalStatus? status}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    var results = _rentals
        .where((r) => r.borrowerName == 'Alex Rivera')
        .toList();
    if (status != null) {
      results = results.where((r) => r.status == status).toList();
    }
    return results;
  }

  @override
  Future<List<RentalRequest>> getLenderRentals({RentalStatus? status}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    var results = _rentals.where((r) => r.lenderName == 'Alex Rivera').toList();
    if (status != null) {
      results = results.where((r) => r.status == status).toList();
    }
    return results;
  }

  @override
  Future<RentalRequest?> getRentalById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    try {
      return _rentals.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RentalRequest> createRentalRequest(RentalRequest request) async {
    await Future.delayed(const Duration(milliseconds: 350));
    _rentals.insert(0, request);
    return request;
  }

  @override
  Future<bool> updateRentalStatus(String id, RentalStatus newStatus) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _rentals.indexWhere((r) => r.id == id);
    if (index >= 0) {
      _rentals[index] = _rentals[index].copyWith(status: newStatus);
      return true;
    }
    return false;
  }

  @override
  Future<bool> requestExtension(String id, DateTime newEndDate) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _rentals.indexWhere((r) => r.id == id);
    if (index >= 0) {
      _rentals[index] = _rentals[index].copyWith(endDate: newEndDate);
      return true;
    }
    return false;
  }

  @override
  Future<bool> toggleAccessoryCheck(
    String id,
    String accessory,
    bool isChecked,
  ) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _rentals.indexWhere((r) => r.id == id);
    if (index >= 0) {
      final updated = Map<String, bool>.from(
        _rentals[index].accessoriesChecklist,
      );
      updated[accessory] = isChecked;
      _rentals[index] = _rentals[index].copyWith(accessoriesChecklist: updated);
      return true;
    }
    return false;
  }
}

final rentalRepositoryProvider = Provider<RentalRepository>((ref) {
  return MockRentalRepository();
});

final borrowerRentalsProvider = FutureProvider.autoDispose<List<RentalRequest>>(
  (ref) async {
    final repo = ref.watch(rentalRepositoryProvider);
    return repo.getBorrowerRentals();
  },
);

final lenderRentalsProvider = FutureProvider.autoDispose<List<RentalRequest>>((
  ref,
) async {
  final repo = ref.watch(rentalRepositoryProvider);
  return repo.getLenderRentals();
});

final rentalDetailsProvider = FutureProvider.autoDispose
    .family<RentalRequest?, String>((ref, id) async {
      final repo = ref.watch(rentalRepositoryProvider);
      return repo.getRentalById(id);
    });
