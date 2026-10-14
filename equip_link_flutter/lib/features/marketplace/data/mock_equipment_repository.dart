import 'equipment_repository.dart';
import 'models/equipment_item.dart';
import '../../../core/widgets/filter_bottom_sheet.dart';

class MockEquipmentRepository implements EquipmentRepository {
  final List<EquipmentItem> _mockItems = [
    const EquipmentItem(
      id: 'fluke-117-multimeter',
      name: 'Fluke 117 True RMS Digital Multimeter Kit',
      category: 'Electronics & STEM',
      condition: 'Like New',
      dailyRate: 6.0,
      weeklyRate: 22.0,
      imageUrl:
          'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=800',
      campusLocation: 'Packard EE Bldg (Locker 14B)',
      lenderName: 'Marcus T.',
      lenderRating: 4.9,
      reviewsCount: 24,
      isAvailable: true,
      description:
          'Ideal for electrical engineering lab coursework (EE101) and senior capstone projects. Features True RMS measurement, VoltAlert non-contact voltage detection, and low input impedance to prevent false readings due to ghost voltage.',
      accessories: [
        'TL75 test lead pair',
        '9V battery installed',
        'TPAK magnetic strap',
        'Protective holster',
      ],
    ),
    const EquipmentItem(
      id: 'ti-84-plus-ce',
      name: 'Texas Instruments TI-84 Plus CE Graphing Calculator',
      category: 'Calculators',
      condition: 'Like New',
      dailyRate: 4.0,
      weeklyRate: 15.0,
      imageUrl:
          'https://images.unsplash.com/photo-1594980596870-8aa52a78d8cd?w=800',
      campusLocation: 'Huang Engineering Center (Locker 14B)',
      lenderName: 'Alex R.',
      lenderRating: 4.9,
      reviewsCount: 18,
      isAvailable: true,
      description:
          'Includes high-resolution color backlit screen, rechargeable battery, and USB charging cable. Pre-loaded with essential polynomial solvers and graphing utilities for MATH 51, calculus, and physics exams.',
      accessories: ['Slide cover', 'Rechargeable battery', 'USB cable'],
    ),
    const EquipmentItem(
      id: 'rigol-ds1054z-oscilloscope',
      name: 'Rigol DS1054Z 50MHz 4-Channel Digital Oscilloscope',
      category: 'Electronics & STEM',
      condition: 'Excellent',
      dailyRate: 12.0,
      weeklyRate: 45.0,
      imageUrl:
          'https://images.unsplash.com/photo-1581092335397-9583fe92d232?w=800',
      campusLocation: 'Gates CS Hall',
      lenderName: 'Priya K.',
      lenderRating: 5.0,
      reviewsCount: 31,
      isAvailable: true,
      description:
          '4-channel digital oscilloscope with UltraVision technology, 12 Mpts memory depth, and 30,000 wfms/s waveform capture rate. Essential for signal analysis and embedded debugging.',
      accessories: ['4x passive probes', 'Power cord', 'USB host cable'],
    ),
    const EquipmentItem(
      id: 'sony-alpha-a6400',
      name: 'Sony Alpha a6400 Mirrorless Camera Kit (16-50mm Lens)',
      category: 'Media & Cameras',
      condition: 'Excellent',
      dailyRate: 18.0,
      weeklyRate: 65.0,
      imageUrl:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800',
      campusLocation: 'Huang Center Lobby',
      lenderName: 'Alex R.',
      lenderRating: 4.8,
      reviewsCount: 15,
      isAvailable: true,
      description:
          '4K video camera with world-class autofocus, 24.2MP APS-C sensor, and 180-degree flip screen. Perfect for student documentaries and journalism coursework.',
      accessories: [
        '16-50mm OSS lens',
        '2x batteries',
        '64GB SD card',
        'Padded carry case',
      ],
    ),
    const EquipmentItem(
      id: 'sparkfun-arduino-kit',
      name: 'SparkFun Inventor\'s Kit for Arduino (v4.1)',
      category: 'Electronics & STEM',
      condition: 'Like New',
      dailyRate: 5.0,
      weeklyRate: 18.0,
      imageUrl:
          'https://images.unsplash.com/photo-1553406830-ef2513450d76?w=800',
      campusLocation: 'Huang Center',
      lenderName: 'David L.',
      lenderRating: 4.8,
      reviewsCount: 12,
      isAvailable: true,
      description:
          'Comprehensive kit including RedBoard microcontroller, breadboard, sensors, servo motors, LCD screen, and jumpers for beginner to intermediate robotics.',
      accessories: ['RedBoard', 'Breadboard', 'Sensor pack', 'Carrying case'],
    ),
    const EquipmentItem(
      id: 'saleae-logic-8',
      name: 'Saleae Logic 8 USB Logic Analyzer',
      category: 'Electronics & STEM',
      condition: 'Excellent',
      dailyRate: 10.0,
      weeklyRate: 35.0,
      imageUrl:
          'https://images.unsplash.com/photo-1563770660941-20978e870e26?w=800',
      campusLocation: 'Old Union Hub',
      lenderName: 'Alex R.',
      lenderRating: 4.9,
      reviewsCount: 9,
      isAvailable: false,
      description:
          '8-channel logic analyzer up to 100 MS/s. Decodes I2C, SPI, UART, CAN, and USB protocols seamlessly for embedded firmware development.',
      accessories: [
        'Logic 8 device',
        'Test lead wire harnesses',
        'Micro-hooks',
      ],
    ),
  ];

  @override
  Future<List<EquipmentItem>> getRecentEquipment() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_mockItems);
  }

  @override
  Future<List<EquipmentItem>> searchEquipment({
    String query = '',
    FilterCriteria? filter,
    String sortBy = 'lowestPrice',
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    var results = List<EquipmentItem>.from(_mockItems);

    if (query.trim().isNotEmpty) {
      final terms = query.toLowerCase().split(RegExp(r'\s+'));
      results = results.where((item) {
        final content = '${item.name} ${item.category} ${item.description}'
            .toLowerCase();
        return terms.every((term) => content.contains(term));
      }).toList();
    }

    if (filter != null) {
      if (filter.categories.isNotEmpty) {
        results = results
            .where((item) => filter.categories.contains(item.category))
            .toList();
      }
      if (filter.conditions.isNotEmpty) {
        results = results
            .where((item) => filter.conditions.contains(item.condition))
            .toList();
      }
      results = results.where((item) {
        return item.dailyRate >= filter.priceRange.start &&
            item.dailyRate <= filter.priceRange.end;
      }).toList();
      if (filter.campusHub != null && filter.campusHub != 'All Campus Hubs') {
        results = results
            .where((item) => item.campusLocation.contains(filter.campusHub!))
            .toList();
      }
      if (filter.availableToday) {
        results = results.where((item) => item.isAvailable).toList();
      }
    }

    if (sortBy == 'lowestPrice') {
      results.sort((a, b) => a.dailyRate.compareTo(b.dailyRate));
    } else if (sortBy == 'highestRated') {
      results.sort((a, b) => b.lenderRating.compareTo(a.lenderRating));
    }

    return results;
  }

  @override
  Future<EquipmentItem?> getEquipmentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    try {
      return _mockItems.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<EquipmentItem>> getMyListings() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Items owned by the student "Alex R."
    return _mockItems.where((i) => i.lenderName == 'Alex R.').toList();
  }

  @override
  Future<EquipmentItem> saveListing(EquipmentItem item) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _mockItems.indexWhere((i) => i.id == item.id);
    if (index >= 0) {
      _mockItems[index] = item;
      return item;
    } else {
      final newItem = item.copyWith(
        id: item.id.isEmpty
            ? 'equip-${DateTime.now().millisecondsSinceEpoch}'
            : item.id,
        lenderName: 'Alex R.',
        lenderRating: 5.0,
      );
      _mockItems.insert(0, newItem);
      return newItem;
    }
  }

  @override
  Future<bool> toggleListingAvailability(String id, bool isAvailable) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _mockItems.indexWhere((i) => i.id == id);
    if (index >= 0) {
      _mockItems[index] = _mockItems[index].copyWith(isAvailable: isAvailable);
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteListing(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _mockItems.removeWhere((i) => i.id == id);
    return true;
  }
}
