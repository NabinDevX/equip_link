import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import 'auth_repository.dart';

/// Auth repository backed by the generated Serverpod email and OTP endpoints.
///
/// Registration and password reset are deliberately kept as multi-step flows:
/// the server-issued request identifiers and finish tokens are never generated
/// or interpreted by the client.
class ServerpodAuthRepository implements AuthRepository {
  UuidValue? _registrationRequestId;
  String? _registrationPassword;
  String? _registrationName;
  String? _registrationUniversity;
  UuidValue? _passwordResetRequestId;
  String? _passwordResetToken;
  String? _currentUserEmail;

  @override
  bool get isAuthenticated => client.auth.isAuthenticated;

  @override
  String? get currentUserEmail => _currentUserEmail;

  @override
  Future<bool> signIn(String email, String password) async {
    final result = await client.emailIdp.login(
      email: email,
      password: password,
    );
    await client.auth.updateSignedInUser(result);
    _currentUserEmail = email;
    return true;
  }

  @override
  Future<bool> register({
    required String name,
    required String email,
    required String university,
    required String password,
  }) async {
    _registrationRequestId = await client.emailIdp.startRegistration(
      email: email,
    );
    _registrationPassword = password;
    _registrationName = name;
    _registrationUniversity = university;
    _currentUserEmail = email;
    return true;
  }

  @override
  Future<bool> verifyEmail(String email, String code) async {
    final requestId = _registrationRequestId;
    final password = _registrationPassword;
    if (requestId == null || password == null || _currentUserEmail != email) {
      throw StateError('Registration verification is no longer available.');
    }

    final registrationToken = await client.emailIdp.verifyRegistrationCode(
      accountRequestId: requestId,
      verificationCode: code,
    );
    final result = await client.emailIdp.finishRegistration(
      registrationToken: registrationToken,
      password: password,
    );
    await client.auth.updateSignedInUser(result);
    await client.profile.updateProfile(
      fullName: _registrationName ?? email.split('@').first,
      university: _registrationUniversity ?? '',
    );
    _registrationRequestId = null;
    _registrationPassword = null;
    _registrationName = null;
    _registrationUniversity = null;
    return true;
  }

  @override
  Future<bool> sendPasswordReset(String email) async {
    _passwordResetRequestId = await client.emailIdp.startPasswordReset(
      email: email,
    );
    return true;
  }

  @override
  Future<bool> requestPasswordReset(String email) => sendPasswordReset(email);

  /// Verifies the password reset code and retains the server-issued finish
  /// token for [finishPasswordReset].
  @override
  Future<bool> verifyPasswordReset(String email, String code) async {
    final requestId = _passwordResetRequestId;
    if (requestId == null) {
      throw StateError('Password reset verification is no longer available.');
    }
    _passwordResetToken = await client.emailIdp.verifyPasswordResetCode(
      passwordResetRequestId: requestId,
      verificationCode: code,
    );
    _currentUserEmail = email;
    return true;
  }

  @override
  Future<bool> finishPasswordReset(String newPassword) async {
    final token = _passwordResetToken;
    if (token == null) {
      throw StateError('Password reset verification is required first.');
    }
    await client.emailIdp.finishPasswordReset(
      finishPasswordResetToken: token,
      newPassword: newPassword,
    );
    _passwordResetRequestId = null;
    _passwordResetToken = null;
    return true;
  }

  Future<dynamic> requestLoginCode(String email) {
    return client.otpAuth.requestLoginCode(email: email);
  }

  Future<bool> verifyLoginCode({
    required String challengeId,
    required String code,
    String? preAuthNonce,
  }) async {
    final result = await client.otpAuth.verifyLoginCode(
      challengeId: challengeId,
      code: code,
      preAuthNonce: preAuthNonce,
    );
    await client.auth.updateSignedInUser(result);
    return true;
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOutDevice();
    _currentUserEmail = null;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ServerpodAuthRepository();
});
