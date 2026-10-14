import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../client.dart';
import 'models/student_profile.dart';
import 'profile_repository.dart';

class ServerpodProfileRepository implements ProfileRepository {
  @override
  Future<StudentProfile> getProfile() async {
    final profile = await client.profile.getMyProfile();
    return _toUiProfile(profile);
  }

  @override
  Future<StudentProfile> updateProfile(StudentProfile profile) async {
    final current = await client.profile.getMyProfile();
    final updated = await client.profile.updateProfile(
      fullName: profile.name,
      university: profile.university,
      studentIdNumber: current.studentIdNumber,
      phoneNumber: current.phoneNumber,
      avatarUrl: current.avatarUrl,
      bio: current.bio,
    );
    return _toUiProfile(updated);
  }

  StudentProfile _toUiProfile(dynamic profile) {
    return StudentProfile(
      id: profile.authUserId.toString(),
      name: profile.fullName,
      email: profile.email,
      university: profile.university,
      department: profile.bio ?? '',
      graduationYear: profile.studentIdNumber ?? '',
      isEmailVerified: profile.isVerified,
      honorCodeScore: 0,
      itemsLent: 0,
      itemsBorrowed: 0,
      totalEarnings: 0,
      defaultPickupHub: '',
    );
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ServerpodProfileRepository();
});

final studentProfileProvider = FutureProvider.autoDispose<StudentProfile>((
  ref,
) async {
  return ref.watch(profileRepositoryProvider).getProfile();
});
