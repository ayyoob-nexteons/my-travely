import 'package:flutter/material.dart';
import '../model/splash_model.dart';
import '../../../core/navigation/navigation_utils.dart';
import '../../../core/storage/local_storage_service.dart';

class SplashViewModel extends ChangeNotifier {
  LocalStorageService? _storageService;
  SplashModel _model = const SplashModel();

  SplashModel get model => _model;

  void _updateModel(SplashModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Future<void> initializeStorage() async {
    _storageService ??= await LocalStorageService.getInstance();
  }

  Future<void> initializeApp(BuildContext context) async {
    try {
      await initializeStorage();
      _updateModel(_model.copyWith(isLoading: true, errorMessage: null));
      
      // Wait for 3 seconds
      await Future.delayed(const Duration(milliseconds: 3000));
      
      // Check if user is logged in
      final isLoggedIn = await _storageService!.isUserLoggedIn();
      
      if (isLoggedIn) {
        NavigationUtils.goToHome(context);
      } else {
        NavigationUtils.goToLogin(context);
      }
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
