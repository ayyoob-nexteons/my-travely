// Mobile-specific stub implementation
class WebGoogleSignInInterop {
  static bool get isAvailable => false;

  static bool get isSignInFunctionAvailable => false;

  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    throw UnsupportedError('Web Google Sign-In is not available on mobile platforms');
  }

  static void signOutGoogle() {
    // No-op for mobile
  }

  static bool isGoogleSignedIn() {
    return false;
  }

  static void initializeGoogleSignIn(String clientId, String buttonId) {
    // No-op for mobile
  }
}
