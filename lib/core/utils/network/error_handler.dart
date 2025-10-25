// core/errors/error_handler.dart

import 'dart:io';
import 'package:dio/dio.dart';

import 'package:tharad/core/utils/network/exceptions.dart';

class ErrorHandler {
  static Exception handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return NetworkException('انتهت مهلة الاتصال. تحقق من الإنترنت.');
    }

    if (e.type == DioExceptionType.connectionError) {
      return NetworkException('لا يوجد اتصال بالإنترنت.');
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final responseData = e.response!.data;

      switch (statusCode) {
        case 400:
          return ValidationException(
            responseData['message'] ?? 'بيانات غير صحيحة',
          );
        case 401:
          return ServerException('غير مصرح لك بالدخول');
        case 403:
          return ServerException('ممنوع الوصول');
        case 404:
          return ServerException('الصفحة غير موجودة');
        case 422:
          if (responseData is Map && responseData.containsKey('errors')) {
            final errors = responseData['errors'] as Map;
            final firstError = errors.values.first;
            final errorMessage = firstError is List
                ? firstError.first
                : firstError;
            return ValidationException(errorMessage.toString());
          }
          return ValidationException(
            responseData['message'] ?? 'خطأ في البيانات المدخلة',
          );
        case 500:
          return ServerException('خطأ في السيرفر. حاول مرة أخرى.');
        default:
          return ServerException(
            responseData['message'] ?? 'حدث خطأ غير متوقع',
          );
      }
    }

    if (e.error != null) {
      return ServerException('خطأ في الاتصال: ${e.error}');
    }

    return ServerException('حدث خطأ أثناء الاتصال بالسيرفر');
  }

  static Exception handleSocketError(SocketException e) {
    return NetworkException('لا يوجد اتصال بالإنترنت');
  }

  static Exception handleGeneralError(dynamic e) {
    if (e is FormatException) {
      return ServerException('خطأ في تنسيق البيانات من السيرفر');
    } else if (e is TypeError) {
      return ServerException('خطأ في البيانات المدخله');
    } else if (e is Exception) {
      return ServerException('حدث خطأ: ${e.toString()}');
    } else {
      return ServerException('حدث خطأ غير متوقع');
    }
  }
}
