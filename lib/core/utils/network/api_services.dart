import 'package:dio/dio.dart';

class ApiService {
  ApiService(this._dio);
  final Dio _dio;
  final String _baseUrl = "https://flutter.tharadtech.com/api/";

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final response = await _dio.get(
        '$_baseUrl$endpoint',
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<dynamic> post({
    required String endpoint,
    dynamic data,
    bool isFormData = false,
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl$endpoint',
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (isFormData) 'Content-Type': 'multipart/form-data',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } catch (e) {}
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    bool isFormData = false,
  }) async {
    try {
      final response = await _dio.put(
        '$_baseUrl$endpoint',
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    String? token,
  }) async {
    try {
      final response = await _dio.delete(
        '$_baseUrl$endpoint',
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ??
          e.response?.statusMessage ??
          "Unknown error";
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timeout";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Receive timeout";
    } else if (e.type == DioExceptionType.badResponse) {
      return "Bad response from server";
    } else {
      return "Unexpected error occurred";
    }
  }
}
