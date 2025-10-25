// Features/Auth/data/repos/AuthreposImplementation.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tharad/Features/Auth/data/models/login_model.dart';
import 'package:tharad/Features/Auth/data/models/sign_up_model.dart';
import 'package:tharad/Features/Auth/data/repos/Authrepos.dart';
import 'package:tharad/core/utils/network/api_services.dart';
import 'package:tharad/core/utils/network/error_handler.dart';

class AuthReposImplementation implements AuthRepos {
  final ApiService apiService;

  AuthReposImplementation({required this.apiService});

  // ============== Sign Up ==============
  @override
  Future<RegistrationResponseModel> signUpService({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String? imagePath,
  }) async {
    try {
      print('=== Repository: Starting Sign Up ===');

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
        print('Image added successfully!');
      } else {
        print('No image provided');
      }

      final response = await apiService.post(
        endpoint: 'auth/register',
        data: formData,
      );

      print('=== Repository: Sign Up Success ===');
      return RegistrationResponseModel.fromJson(response);
    } on DioException catch (e) {
      print('=== Repository: DioException ===');
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      print('=== Repository: SocketException ===');
      throw ErrorHandler.handleSocketError(e);
    } catch (e, stackTrace) {
      print('=== Repository: Unknown Error ===');
      print('Error: $e');
      print('StackTrace: $stackTrace');
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
}
