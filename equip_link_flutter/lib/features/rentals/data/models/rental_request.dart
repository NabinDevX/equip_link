enum RentalStatus {
  pending,
  approved,
  active,
  returnDue,
  completed,
  cancelled,
  rejected,
}

enum HandoffMethod { smartLocker, inPerson }

class RentalRequest {
  final String id;
  final String equipmentId;
  final String equipmentName;
  final String equipmentCategory;
  final String equipmentImageUrl;
  final double dailyRate;

  final String borrowerName;
  final String borrowerUniversity;
  final String lenderName;
  final String lenderUniversity;

  final DateTime startDate;
  final DateTime endDate;
  final HandoffMethod handoffMethod;
  final String campusLocation;
  final String? lockerPin;
  final String? note;

  final double baseAmount;
  final double discountAmount;
  final double serviceFee;
  final double totalAmount;

  final RentalStatus status;
  final Map<String, bool> accessoriesChecklist;
  final DateTime createdAt;

  const RentalRequest({
    required this.id,
    required this.equipmentId,
    required this.equipmentName,
    required this.equipmentCategory,
    required this.equipmentImageUrl,
    required this.dailyRate,
    required this.borrowerName,
    required this.borrowerUniversity,
    required this.lenderName,
    required this.lenderUniversity,
    required this.startDate,
    required this.endDate,
    required this.handoffMethod,
    required this.campusLocation,
    this.lockerPin,
    this.note,
    required this.baseAmount,
    required this.discountAmount,
    required this.serviceFee,
    required this.totalAmount,
    required this.status,
    this.accessoriesChecklist = const {},
    required this.createdAt,
  });

  int get rentalDays => endDate.difference(startDate).inDays.clamp(1, 99);

  RentalRequest copyWith({
    String? id,
    String? equipmentId,
    String? equipmentName,
    String? equipmentCategory,
    String? equipmentImageUrl,
    double? dailyRate,
    String? borrowerName,
    String? borrowerUniversity,
    String? lenderName,
    String? lenderUniversity,
    DateTime? startDate,
    DateTime? endDate,
    HandoffMethod? handoffMethod,
    String? campusLocation,
    String? lockerPin,
    String? note,
    double? baseAmount,
    double? discountAmount,
    double? serviceFee,
    double? totalAmount,
    RentalStatus? status,
    Map<String, bool>? accessoriesChecklist,
    DateTime? createdAt,
  }) {
    return RentalRequest(
      id: id ?? this.id,
      equipmentId: equipmentId ?? this.equipmentId,
      equipmentName: equipmentName ?? this.equipmentName,
      equipmentCategory: equipmentCategory ?? this.equipmentCategory,
      equipmentImageUrl: equipmentImageUrl ?? this.equipmentImageUrl,
      dailyRate: dailyRate ?? this.dailyRate,
      borrowerName: borrowerName ?? this.borrowerName,
      borrowerUniversity: borrowerUniversity ?? this.borrowerUniversity,
      lenderName: lenderName ?? this.lenderName,
      lenderUniversity: lenderUniversity ?? this.lenderUniversity,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      handoffMethod: handoffMethod ?? this.handoffMethod,
      campusLocation: campusLocation ?? this.campusLocation,
      lockerPin: lockerPin ?? this.lockerPin,
      note: note ?? this.note,
      baseAmount: baseAmount ?? this.baseAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      serviceFee: serviceFee ?? this.serviceFee,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      accessoriesChecklist: accessoriesChecklist ?? this.accessoriesChecklist,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
