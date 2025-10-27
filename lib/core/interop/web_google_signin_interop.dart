// Web-specific JavaScript interop
import 'dart:js' as js;

class WebGoogleSignInInterop {
  static bool get isAvailable => js.context['dartInterop'] != null;

  static bool get isSignInFunctionAvailable => 
      js.context['dartInterop']?['signInWithGoogle'] != null;

  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      if (!isAvailable) {
        throw Exception('dartInterop not available');
      }

      if (!isSignInFunctionAvailable) {
        throw Exception('signInWithGoogle function not available');
      }

      final result = js.context['dartInterop']['signInWithGoogle'].call();
      
      if (result != null) {
        final jsObject = result as js.JsObject;
        return {
          'email': jsObject['email']?.toString() ?? '',
          'name': jsObject['name']?.toString() ?? '',
          'picture': jsObject['picture']?.toString() ?? '',
          'sub': jsObject['sub']?.toString() ?? '',
        };
      }
      return null;
    } catch (e) {
      throw Exception('Web Google Sign-In error: $e');
    }
  }

  static void signOutGoogle() {
    if (isAvailable && js.context['dartInterop']['signOutGoogle'] != null) {
      js.context['dartInterop']['signOutGoogle'].call();
    }
  }

  static bool isGoogleSignedIn() {
    if (isAvailable && js.context['dartInterop']['isGoogleSignedIn'] != null) {
      final result = js.context['dartInterop']['isGoogleSignedIn'].call();
      return result ?? false;
    }
    return false;
  }

  static void initializeGoogleSignIn(String clientId, String buttonId) {
    if (isAvailable && js.context['dartInterop']['initializeGoogleSignIn'] != null) {
      js.context['dartInterop']['initializeGoogleSignIn'].call([clientId, buttonId]);
    }
  }
}
