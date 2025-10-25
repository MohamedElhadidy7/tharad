// core/utils/helpers/cache_helper.dart

import 'package:get_storage/get_storage.dart';

class CacheHelper {
  static final GetStorage _storage = GetStorage();
  static const String _tokenKey = 'auth_token';

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
}
