abstract class AuthRepository {
  Future<bool> signIn(String email, String password);
  Future<bool> register({
    required String name,
    required String email,
    required String university,
    required String password,
  });
  Future<bool> verifyEmail(String email, String code);
  Future<bool> sendPasswordReset(String email);
  Future<bool> requestPasswordReset(String email);
  Future<bool> verifyPasswordReset(String email, String code);
  Future<bool> finishPasswordReset(String newPassword);
  Future<void> signOut();
  bool get isAuthenticated;
  String? get currentUserEmail;
}
