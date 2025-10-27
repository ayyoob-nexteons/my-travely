import '../../../core/storage/user_session.dart';

class LoginModel {
  final bool isLoading;
  final String? errorMessage;
  final String email;
  final String password;
  final bool isGoogleLoading;
  final LoginState loginState;
  final AuthMethod? selectedAuthMethod;

  const LoginModel({
    this.isLoading = false,
    this.errorMessage,
    this.email = '',
    this.password = '',
    this.isGoogleLoading = false,
    this.loginState = LoginState.loggedOut,
    this.selectedAuthMethod,
  });

  LoginModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? email,
    String? password,
    bool? isGoogleLoading,
    LoginState? loginState,
    AuthMethod? selectedAuthMethod,
  }) {
    return LoginModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      loginState: loginState ?? this.loginState,
      selectedAuthMethod: selectedAuthMethod ?? this.selectedAuthMethod,
    );
  }
}
