import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Endpoint for student profile management in EquipLink.
class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Retrieves the student profile of the currently signed-in user.
  Future<StudentProfile> getMyProfile(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    var profile = (await StudentProfile.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      limit: 1,
    )).firstOrNull;

    if (profile == null) {
      final userProfile = await session.authenticated!.userProfile(session);
      final email = userProfile?.email ?? 'student@campus.edu';
      final name = userProfile?.fullName ?? email.split('@').first;

      profile = StudentProfile(
        authUserId: authUserId,
        fullName: name,
        email: email,
        university: 'Campus University',
        isVerified: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await StudentProfile.db.insertRow(session, profile);
    }

    return profile;
  }

  /// Retrieves the signed-in user's profile by its associated auth user id.
  ///
  /// Private profile fields are not exposed as a public lookup. A dedicated
  /// public-profile DTO should be introduced before exposing other students'
  /// profiles.
  Future<StudentProfile?> getProfile(
    Session session,
    UuidValue authUserId,
  ) async {
    final currentUserId = session.authenticated?.authUserId;
    if (currentUserId == null) {
      throw EquipLinkException(
        message: 'Authentication required.',
        statusCode: 401,
      );
    }
    if (currentUserId != authUserId) {
      throw EquipLinkException(
        message: 'You are not authorized to view this profile.',
        statusCode: 403,
      );
    }

    return (await StudentProfile.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      limit: 1,
    )).firstOrNull;
  }

  /// Updates the profile information of the currently authenticated student.
  Future<StudentProfile> updateProfile(
    Session session, {
    required String fullName,
    required String university,
    String? phoneNumber,
    String? bio,
    String? studentIdNumber,
    String? avatarUrl,
  }) async {
    final profile = await getMyProfile(session);

    profile.fullName = fullName.trim();
    profile.university = university.trim();
    profile.phoneNumber = phoneNumber?.trim();
    profile.bio = bio?.trim();
    profile.studentIdNumber = studentIdNumber?.trim();
    profile.avatarUrl = avatarUrl?.trim();
    profile.updatedAt = DateTime.now();

    return await StudentProfile.db.updateRow(session, profile);
  }
}
