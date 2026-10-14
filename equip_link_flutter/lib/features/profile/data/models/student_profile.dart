class StudentProfile {
  final String id;
  final String name;
  final String email;
  final String university;
  final String department;
  final String graduationYear;
  final bool isEmailVerified;
  final double honorCodeScore;
  final int itemsLent;
  final int itemsBorrowed;
  final double totalEarnings;
  final String defaultPickupHub;

  const StudentProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.university,
    required this.department,
    required this.graduationYear,
    required this.isEmailVerified,
    required this.honorCodeScore,
    required this.itemsLent,
    required this.itemsBorrowed,
    required this.totalEarnings,
    required this.defaultPickupHub,
  });

  StudentProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? university,
    String? department,
    String? graduationYear,
    bool? isEmailVerified,
    double? honorCodeScore,
    int? itemsLent,
    int? itemsBorrowed,
    double? totalEarnings,
    String? defaultPickupHub,
  }) {
    return StudentProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      university: university ?? this.university,
      department: department ?? this.department,
      graduationYear: graduationYear ?? this.graduationYear,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      honorCodeScore: honorCodeScore ?? this.honorCodeScore,
      itemsLent: itemsLent ?? this.itemsLent,
      itemsBorrowed: itemsBorrowed ?? this.itemsBorrowed,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      defaultPickupHub: defaultPickupHub ?? this.defaultPickupHub,
    );
  }
}
