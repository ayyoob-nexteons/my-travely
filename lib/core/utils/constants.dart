class AppConstants {
  // App info
  static const String appName = 'My Travely';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String isLoggedInKey = 'is_logged_in';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String userPhotoKey = 'user_photo';
  static const String userSessionKey = 'user_session';
  static const String authMethodKey = 'auth_method';
  static const String userRoleKey = 'user_role';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Timeouts
  static const int splashDuration = 3000; // 3 seconds
  static const int apiTimeout = 30000; // 30 seconds

  // Google Sign-In scopes
  static const List<String> googleSignInScopes = [
    'email',
    'profile',
  ];

  // Google Sign-In Client IDs
  // Replace these with your actual client IDs from Google Cloud Console
  static const String googleWebClientId = 'YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com';
  static const String googleAndroidClientId = 'YOUR_ANDROID_CLIENT_ID.apps.googleusercontent.com';
  static const String googleIosClientId = 'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';

  // Error messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String validationError = 'Please check your input and try again.';
}
