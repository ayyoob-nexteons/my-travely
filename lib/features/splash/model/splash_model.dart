class SplashModel {
  final bool isLoading;
  final String? errorMessage;

  const SplashModel({
    this.isLoading = true,
    this.errorMessage,
  });

  SplashModel copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return SplashModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
