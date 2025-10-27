class SignupModel {
  final bool isLoading;
  final String? errorMessage;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isGoogleLoading;

  const SignupModel({
    this.isLoading = false,
    this.errorMessage,
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isGoogleLoading = false,
  });

  SignupModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isGoogleLoading,
  }) {
    return SignupModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
    );
  }
}
