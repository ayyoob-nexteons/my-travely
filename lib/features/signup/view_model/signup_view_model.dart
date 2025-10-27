import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/signup_model.dart';
import '../../../core/navigation/navigation_utils.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../../core/storage/user_session.dart';
import '../../../core/utils/common_utils.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/formatters.dart';

// Conditional import for web-specific JavaScript interop
import '../../../core/interop/web_google_signin_interop.dart' if (dart.library.io) '../../../core/interop/web_google_signin_interop_stub.dart';

class SignupViewModel extends ChangeNotifier {
  late final GoogleSignIn _googleSignIn;
  
  LocalStorageService? _storageService;
  SignupModel _model = const SignupModel();

  SignupModel get model => _model;

  void _updateModel(SignupModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Future<void> initializeStorage() async {
    _storageService ??= await LocalStorageService.getInstance();
  }

  Future<void> initializeGoogleSignIn() async {
    if (kIsWeb) {
      // For web, we don't need to initialize GoogleSignIn here
      // The web implementation uses JavaScript interop
      return;
    } else {
      // For Android, use serverClientId instead of clientId
      _googleSignIn = GoogleSignIn(
        scopes: AppConstants.googleSignInScopes,
        serverClientId: AppConstants.googleAndroidClientId,
      );
    }
  }

  void updateName(String name) {
    _updateModel(_model.copyWith(name: name));
  }

  void updateEmail(String email) {
    _updateModel(_model.copyWith(email: email));
  }

  void updatePassword(String password) {
    _updateModel(_model.copyWith(password: password));
  }

  void updateConfirmPassword(String confirmPassword) {
    _updateModel(_model.copyWith(confirmPassword: confirmPassword));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      await initializeStorage();
      _updateModel(_model.copyWith(isLoading: true, errorMessage: null));

      // Validate inputs
      final nameError = CommonUtils.validateName(_model.name);
      final emailError = CommonUtils.validateEmail(_model.email);
      final passwordError = CommonUtils.validatePassword(_model.password);
      final confirmPasswordError = CommonUtils.validateConfirmPassword(
        _model.password,
        _model.confirmPassword,
      );

      if (nameError != null || emailError != null || 
          passwordError != null || confirmPasswordError != null) {
        _updateModel(_model.copyWith(
          isLoading: false,
          errorMessage: nameError ?? emailError ?? passwordError ?? confirmPasswordError,
        ));
        return;
      }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Create user session
      final userSession = UserSession(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: AppFormatters.formatEmail(_model.email),
        name: AppFormatters.formatName(_model.name),
        authMethod: AuthMethod.email,
        loginTime: DateTime.now(),
      );

      await _storageService!.saveUserSession(userSession);

      _updateModel(_model.copyWith(isLoading: false));
      NavigationUtils.goToHome(context);
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      await initializeStorage();
      
      _updateModel(_model.copyWith(
        isGoogleLoading: true, 
        errorMessage: null,
      ));

      if (kIsWeb) {
        // Use web-specific Google Sign-In
        await _signUpWithGoogleWeb(context);
      } else {
        // Use mobile Google Sign-In
        await initializeGoogleSignIn();
        final user = await _googleSignIn.signIn();
        
        if (user != null) {
          await _createUserSession(user.email, user.displayName ?? user.email.split('@')[0], user.photoUrl);
        }
        
        // Always navigate to hotel list screen regardless of success or failure
        _updateModel(_model.copyWith(isGoogleLoading: false));
        NavigationUtils.goToHome(context);
      }
    } catch (e) {
      // On error, still navigate to hotel list screen
      _updateModel(_model.copyWith(isGoogleLoading: false));
      NavigationUtils.goToHome(context);
    }
  }

  Future<void> _createUserSession(String email, String name, String? photoUrl) async {
    final userSession = UserSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: AppFormatters.formatEmail(email),
      name: AppFormatters.formatName(name),
      photoUrl: photoUrl,
      authMethod: AuthMethod.google,
      loginTime: DateTime.now(),
    );

    await _storageService!.saveUserSession(userSession);
  }

  Future<void> _signUpWithGoogleWeb(BuildContext context) async {
    try {
      // Check if web interop is available
      if (!WebGoogleSignInInterop.isAvailable) {
        _updateModel(_model.copyWith(isGoogleLoading: false));
        NavigationUtils.goToHome(context);
        return;
      }

      // Check if signInWithGoogle function exists
      if (!WebGoogleSignInInterop.isSignInFunctionAvailable) {
        _updateModel(_model.copyWith(isGoogleLoading: false));
        NavigationUtils.goToHome(context);
        return;
      }

      // Call the web JavaScript function
      final result = await WebGoogleSignInInterop.signInWithGoogle();
      
      if (result != null) {
        final email = result['email'] ?? '';
        final displayName = result['name'] ?? '';
        final photoUrl = result['picture'] ?? '';
        
        await _createUserSession(email, displayName, photoUrl);
      }
      
      // Always navigate to hotel list screen regardless of success or failure
      _updateModel(_model.copyWith(isGoogleLoading: false));
      NavigationUtils.goToHome(context);
    } catch (e) {
      // On error, still navigate to hotel list screen
      _updateModel(_model.copyWith(isGoogleLoading: false));
      NavigationUtils.goToHome(context);
    }
  }

  void clearError() {
    _updateModel(_model.copyWith(errorMessage: null));
  }
}
