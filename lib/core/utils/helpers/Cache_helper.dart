import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static final GetStorage _storage = GetStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userProfileKey = 'user_profile';

  static Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  static String? getToken() {
    return _storage.read(_tokenKey);
  }

  static bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearToken() async {
    await _storage.remove(_tokenKey);
  }

  static Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
    final jsonString = jsonEncode(profileData);
    await _storage.write(_userProfileKey, jsonString);
  }

  static Map<String, dynamic>? getUserProfile() {
    try {
      final data = _storage.read(_userProfileKey);
      if (data != null && data is String) {
        return jsonDecode(data) as Map<String, dynamic>;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<void> clearUserProfile() async {
    await _storage.remove(_userProfileKey);
  }

  static Future<void> clearAll() async {
    await _storage.erase();
  }
}
