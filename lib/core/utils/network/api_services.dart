import 'package:dio/dio.dart';
import 'package:tharad/core/utils/helpers/Cache_helper.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl = 'https://flutter.tharadtech.com/api/';

  ApiService(Dio dio) : _dio = dio {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = false,
  }) async {
    try {
      if (requiresAuth) {
        final token = CacheHelper.getToken();
        if (token != null && token.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $token';
        } else {
          throw Exception('Authentication required - No token found');
        }
      }

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post({
    required String endpoint,
    dynamic data,
    bool requiresAuth = false,
  }) async {
    try {
      if (requiresAuth) {
        final token = CacheHelper.getToken();
        if (token != null && token.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $token';
        } else {
          throw Exception('Authentication required - No token found');
        }
      }

      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    dynamic data,
    bool requiresAuth = false,
  }) async {
    try {
      if (requiresAuth) {
        final token = CacheHelper.getToken();
        if (token != null && token.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $token';
        } else {
          throw Exception('Authentication required - No token found');
        }
      }

      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    bool requiresAuth = false,
  }) async {
    try {
      if (requiresAuth) {
        final token = CacheHelper.getToken();
        if (token != null && token.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $token';
        } else {
          throw Exception('Authentication required - No token found');
        }
      }

      final response = await _dio.delete(endpoint);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
