import 'package:flutter/material.dart';
import '../../../core/navigation/navigation_utils.dart';
import '../../../core/storage/local_storage_service.dart';
import '../../../core/storage/user_session.dart';

class HomeViewModel extends ChangeNotifier {
  LocalStorageService? _storageService;
  UserSession? _userSession;

  UserSession? get userSession => _userSession;
  String? get userName => _userSession?.name;
  String? get userEmail => _userSession?.email;
  String? get userPhoto => _userSession?.photoUrl;
  AuthMethod? get authMethod => _userSession?.authMethod;
  UserRole? get userRole => _userSession?.role;
  DateTime? get loginTime => _userSession?.loginTime;

  Future<void> initializeStorage() async {
    _storageService ??= await LocalStorageService.getInstance();
  }

  Future<void> loadUserData() async {
    await initializeStorage();
    _userSession = await _storageService!.getUserSession();
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await initializeStorage();
    await _storageService!.clearUserSession();
    NavigationUtils.goToLogin(context);
  }

  Future<void> updateLastActiveTime() async {
    if (_userSession != null) {
      final updatedSession = _userSession!.copyWith(
        lastActiveTime: DateTime.now(),
      );
      await _storageService!.saveUserSession(updatedSession);
      _userSession = updatedSession;
      notifyListeners();
    }
  }
}
