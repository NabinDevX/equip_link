import 'models/student_profile.dart';

abstract class ProfileRepository {
  Future<StudentProfile> getProfile();
  Future<StudentProfile> updateProfile(StudentProfile profile);
}
