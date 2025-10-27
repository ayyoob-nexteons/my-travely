import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/constants.dart';

// Conditional import for web-specific JavaScript interop
import '../interop/web_google_signin_interop.dart' if (dart.library.io) '../interop/web_google_signin_interop_stub.dart';

class GoogleSignInService {
  static GoogleSignIn? _googleSignIn;
  
  static Future<void> initialize() async {
    if (kIsWeb) {
      // For web, we'll use the renderButton approach
      _initializeWebGoogleSignIn();
    } else {
      // For mobile platforms, use traditional Google Sign-In
      _googleSignIn = GoogleSignIn(
        scopes: AppConstants.googleSignInScopes,
      );
    }
  }

  static void _initializeWebGoogleSignIn() {
    // Initialize Google Identity Services for web
    html.window.addEventListener('load', (event) {
      _renderGoogleSignInButton();
    });
  }

  static Future<void> signOut() async {
    if (kIsWeb) {
      WebGoogleSignInInterop.signOutGoogle();
    } else {
      await _googleSignIn?.signOut();
    }
  }

  static Future<bool> isSignedIn() async {
    if (kIsWeb) {
      return WebGoogleSignInInterop.isGoogleSignedIn();
    } else {
      return await _googleSignIn?.isSignedIn() ?? false;
    }
  }

  static void _renderGoogleSignInButton() {
    // This will be called from the web side
    if (kIsWeb) {
      WebGoogleSignInInterop.initializeGoogleSignIn(
        AppConstants.googleWebClientId,
        'google-signin-button'
      );
    }
  }

  static Future<Map<String, dynamic>?> signInWeb() async {
    try {
      if (!kIsWeb) return null;
      
      return await WebGoogleSignInInterop.signInWithGoogle();
    } catch (e) {
      print('Web Google Sign-In error: $e');
      return null;
    }
  }

  static Future<GoogleSignInAccount?> signInMobile() async {
    return await _googleSignIn?.signIn();
  }
}
