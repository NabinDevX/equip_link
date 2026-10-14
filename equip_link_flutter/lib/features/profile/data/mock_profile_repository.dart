import 'models/student_profile.dart';
import 'profile_repository.dart';

class MockProfileRepository implements ProfileRepository {
  StudentProfile _profile = const StudentProfile(
    id: 'student-alex-rivera',
    name: 'Alex Rivera',
    email: 'alex.rivera@stanford.edu',
    university: 'Stanford University',
    department: 'Electrical Engineering & CS',
    graduationYear: 'Class of 2026',
    isEmailVerified: true,
    honorCodeScore: 4.9,
    itemsLent: 6,
    itemsBorrowed: 12,
    totalEarnings: 68.0,
    defaultPickupHub: 'Packard EE Bldg (Locker 14B)',
  );

  @override
  Future<StudentProfile> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _profile;
  }

  @override
  Future<StudentProfile> updateProfile(StudentProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _profile = profile;
    return _profile;
  }
}
