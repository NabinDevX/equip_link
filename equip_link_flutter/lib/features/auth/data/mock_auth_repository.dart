import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  bool _isAuthenticated = false;
  String? _currentUserEmail;

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  String? get currentUserEmail => _currentUserEmail;

  @override
  Future<bool> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _isAuthenticated = true;
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
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUserEmail = email;
    return true;
  }

  @override
  Future<bool> verifyEmail(String email, String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isAuthenticated = true;
    _currentUserEmail = email;
    return true;
  }

  @override
  Future<bool> sendPasswordReset(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  @override
  Future<bool> requestPasswordReset(String email) => sendPasswordReset(email);

  @override
  Future<bool> verifyPasswordReset(String email, String code) async =>
      code.trim().length == 6;

  @override
  Future<bool> finishPasswordReset(String newPassword) async =>
      newPassword.length >= 8;

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isAuthenticated = false;
    _currentUserEmail = null;
  }
}
