import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user/user_model.dart';

// Service for persisting user session data
class SessionStorage {
  static const String userKey = 'cached_user';
  static const String isLoggedInKey = 'is_logged_in';

  final SharedPreferences prefs;

  SessionStorage(this.prefs);

  // Save user session
  Future<void> saveSession(UserModel user) async {
    await prefs.setString(userKey, jsonEncode(user.toJson()));
    await prefs.setBool(isLoggedInKey, true);
  }

  // Clear user session
  Future<void> clearSession() async {
    await prefs.remove(userKey);
    await prefs.setBool(isLoggedInKey, false);
  }

  // Get cached user if exists
  UserModel? getCachedUser() {
    final userJson = prefs.getString(userKey);
    if (userJson != null) {
      try {
        return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Update cached user
  Future<void> updateCachedUser(UserModel user) async {
    if (isLoggedIn()) {
      await prefs.setString(userKey, jsonEncode(user.toJson()));
    }
  }
}
