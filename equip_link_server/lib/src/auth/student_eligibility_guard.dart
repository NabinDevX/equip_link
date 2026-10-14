import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Blocks lending and rental actions when a student's institutional claim has
/// not been verified or their student ID card has expired.
Future<void> requireEligibleStudent(Session session) async {
  final authUserId = session.authenticated?.authUserId;
  if (authUserId == null) {
    throw EquipLinkException(
      message: 'Authentication required.',
      statusCode: 401,
    );
  }

  final identity = (await StudentIdentity.db.find(
    session,
    where: (t) => t.authUserId.equals(authUserId),
    limit: 1,
  )).firstOrNull;
  if (identity == null ||
      identity.eligibilityStatus != 'eligible' ||
      !identity.emailVerified ||
      !identity.studentIdCardVerified ||
      identity.studentIdExpiresAt == null) {
    throw EquipLinkException(
      message: 'Verify your student email and ID card to continue.',
      statusCode: 403,
    );
  }

  if (DateTime.now().isAfter(identity.studentIdExpiresAt!)) {
    identity
      ..eligibilityStatus = 'expired'
      ..updatedAt = DateTime.now();
    await StudentIdentity.db.updateRow(session, identity);
    throw EquipLinkException(
      message: 'Your student ID has expired. Reverify to continue.',
      statusCode: 403,
    );
  }
}
