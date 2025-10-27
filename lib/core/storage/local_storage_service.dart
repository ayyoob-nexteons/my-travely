import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_session.dart';
import '../utils/constants.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _prefs;

  LocalStorageService._();

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // User Session Management
  Future<void> saveUserSession(UserSession session) async {
    try {
      final sessionJson = jsonEncode(session.toJson());
      await _prefs!.setString(AppConstants.userSessionKey, sessionJson);
      await _prefs!.setBool(AppConstants.isLoggedInKey, true);
      await _prefs!.setString(AppConstants.userEmailKey, session.email);
      await _prefs!.setString(AppConstants.userNameKey, session.name);
      if (session.photoUrl != null) {
        await _prefs!.setString(AppConstants.userPhotoKey, session.photoUrl!);
      }
      await _prefs!.setString(AppConstants.authMethodKey, session.authMethod.name);
      await _prefs!.setString(AppConstants.userRoleKey, session.role.name);
    } catch (e) {
      throw Exception('Failed to save user session: $e');
    }
  }

  Future<UserSession?> getUserSession() async {
    try {
      final sessionJson = _prefs!.getString(AppConstants.userSessionKey);
      if (sessionJson != null) {
        final sessionMap = jsonDecode(sessionJson) as Map<String, dynamic>;
        return UserSession.fromJson(sessionMap);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user session: $e');
    }
  }

  Future<void> clearUserSession() async {
    try {
      await _prefs!.remove(AppConstants.userSessionKey);
      await _prefs!.remove(AppConstants.isLoggedInKey);
      await _prefs!.remove(AppConstants.userEmailKey);
      await _prefs!.remove(AppConstants.userNameKey);
      await _prefs!.remove(AppConstants.userPhotoKey);
      await _prefs!.remove(AppConstants.authMethodKey);
      await _prefs!.remove(AppConstants.userRoleKey);
    } catch (e) {
      throw Exception('Failed to clear user session: $e');
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      return _prefs!.getBool(AppConstants.isLoggedInKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      return _prefs!.getString(AppConstants.userEmailKey);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUserName() async {
    try {
      return _prefs!.getString(AppConstants.userNameKey);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUserPhoto() async {
    try {
      return _prefs!.getString(AppConstants.userPhotoKey);
    } catch (e) {
      return null;
    }
  }

  Future<AuthMethod> getAuthMethod() async {
    try {
      final methodString = _prefs!.getString(AppConstants.authMethodKey);
      if (methodString != null) {
        return AuthMethod.values.firstWhere(
          (e) => e.name == methodString,
          orElse: () => AuthMethod.unknown,
        );
      }
      return AuthMethod.unknown;
    } catch (e) {
      return AuthMethod.unknown;
    }
  }

  Future<UserRole> getUserRole() async {
    try {
      final roleString = _prefs!.getString(AppConstants.userRoleKey);
      if (roleString != null) {
        return UserRole.values.firstWhere(
          (e) => e.name == roleString,
          orElse: () => UserRole.user,
        );
      }
      return UserRole.user;
    } catch (e) {
      return UserRole.user;
    }
  }

  // App Settings
  Future<void> saveAppSetting(String key, dynamic value) async {
    try {
      if (value is String) {
        await _prefs!.setString(key, value);
      } else if (value is int) {
        await _prefs!.setInt(key, value);
      } else if (value is double) {
        await _prefs!.setDouble(key, value);
      } else if (value is bool) {
        await _prefs!.setBool(key, value);
      } else if (value is List<String>) {
        await _prefs!.setStringList(key, value);
      }
    } catch (e) {
      throw Exception('Failed to save app setting: $e');
    }
  }

  Future<T?> getAppSetting<T>(String key) async {
    try {
      if (T == String) {
        return _prefs!.getString(key) as T?;
      } else if (T == int) {
        return _prefs!.getInt(key) as T?;
      } else if (T == double) {
        return _prefs!.getDouble(key) as T?;
      } else if (T == bool) {
        return _prefs!.getBool(key) as T?;
      } else if (T == List<String>) {
        return _prefs!.getStringList(key) as T?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Cache Management
  Future<void> saveCacheData(String key, Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      await _prefs!.setString('cache_$key', jsonString);
    } catch (e) {
      throw Exception('Failed to save cache data: $e');
    }
  }

  Future<Map<String, dynamic>?> getCacheData(String key) async {
    try {
      final jsonString = _prefs!.getString('cache_$key');
      if (jsonString != null) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> clearCacheData(String key) async {
    try {
      await _prefs!.remove('cache_$key');
    } catch (e) {
      throw Exception('Failed to clear cache data: $e');
    }
  }

  Future<void> clearAllCache() async {
    try {
      final keys = _prefs!.getKeys();
      for (final key in keys) {
        if (key.startsWith('cache_')) {
          await _prefs!.remove(key);
        }
      }
    } catch (e) {
      throw Exception('Failed to clear all cache: $e');
    }
  }

  // Clear all data
  Future<void> clearAllData() async {
    try {
      await _prefs!.clear();
    } catch (e) {
      throw Exception('Failed to clear all data: $e');
    }
  }
}
