/// Formats provider errors for a concise diagnostic shown in the auth screens.
String readableGoogleSignInError(Object error) {
  final detail = error.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
  if (detail.isEmpty) {
    return 'Google sign-in failed. Check the Android OAuth package name and '
        'debug SHA-1 configuration.';
  }

  const maxLength = 180;
  final conciseDetail = detail.length <= maxLength
      ? detail
      : '${detail.substring(0, maxLength)}…';
  return 'Google sign-in failed: $conciseDetail';
}
