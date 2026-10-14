class EquipmentItem {
  final String id;
  final String name;
  final String category;
  final String condition;
  final double dailyRate;
  final double weeklyRate;
  final String imageUrl;
  final String campusLocation;
  final String lenderName;
  final double lenderRating;
  final int reviewsCount;
  final bool isAvailable;
  final String description;
  final List<String> accessories;

  const EquipmentItem({
    required this.id,
    required this.name,
    required this.category,
    required this.condition,
    required this.dailyRate,
    required this.weeklyRate,
    required this.imageUrl,
    required this.campusLocation,
    required this.lenderName,
    required this.lenderRating,
    this.reviewsCount = 20,
    this.isAvailable = true,
    this.description = '',
    this.accessories = const [],
  });

  String get title => name;
  double get rating => lenderRating;
  bool get isOwnerVerified => true;

  EquipmentItem copyWith({
    String? id,
    String? name,
    String? category,
    String? condition,
    double? dailyRate,
    double? weeklyRate,
    String? imageUrl,
    String? campusLocation,
    String? lenderName,
    double? lenderRating,
    int? reviewsCount,
    bool? isAvailable,
    String? description,
    List<String>? accessories,
  }) {
    return EquipmentItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      dailyRate: dailyRate ?? this.dailyRate,
      weeklyRate: weeklyRate ?? this.weeklyRate,
      imageUrl: imageUrl ?? this.imageUrl,
      campusLocation: campusLocation ?? this.campusLocation,
      lenderName: lenderName ?? this.lenderName,
      lenderRating: lenderRating ?? this.lenderRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      accessories: accessories ?? this.accessories,
    );
  }
}
