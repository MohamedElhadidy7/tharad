import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tharad/Features/Auth/data/models/logOut_model.dart';
import 'package:tharad/Features/Auth/data/models/login_model.dart';
import 'package:tharad/Features/Auth/data/models/otp_model.dart';
import 'package:tharad/Features/Auth/data/models/sign_up_model.dart';
import 'package:tharad/Features/Auth/data/repos/Authrepos.dart';
import 'package:tharad/core/utils/network/api_services.dart';
import 'package:tharad/core/utils/network/error_handler.dart';

class AuthReposImplementation implements AuthRepos {
  final ApiService apiService;

  AuthReposImplementation({required this.apiService});

  @override
  Future<RegistrationResponseModel> signUpService({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String? imagePath,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      });

      if (imagePath != null && imagePath.isNotEmpty) {
        final file = File(imagePath);

        if (!await file.exists()) {
          throw Exception('الملف غير موجود');
        }

        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(
              imagePath,
              filename: imagePath.split('/').last,
            ),
          ),
        );
      }

      final response = await apiService.post(
        endpoint: 'auth/register',
        data: formData,
      );

      return RegistrationResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      throw ErrorHandler.handleSocketError(e);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleGeneralError(e);
    }
  }

  @override
  Future<LoginResponseModel> loginService({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: 'auth/login',
        data: {'email': email, 'password': password},
      );
      return LoginResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      throw ErrorHandler.handleSocketError(e);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleGeneralError(e);
    }
  }

  @override
  Future<VerifyOtpModel> verifyOtpService({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await apiService.get(
        endpoint: 'otp',
        queryParameters: {'email': email, 'otp': otp},
      );

      return VerifyOtpModel.fromJson(response);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      throw ErrorHandler.handleSocketError(e);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleGeneralError(e);
    }
  }

  @override
  Future<LogoutModel> logoutService() async {
    try {
      final response = await apiService.delete(
        endpoint: 'auth/logout',
        requiresAuth: true,
      );

      return LogoutModel.fromJson(response);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      throw ErrorHandler.handleSocketError(e);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleGeneralError(e);
    }
  }
}
