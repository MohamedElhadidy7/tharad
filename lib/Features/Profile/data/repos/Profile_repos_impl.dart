import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tharad/Features/Profile/data/models/update_profile_model.dart';
import 'package:tharad/Features/Profile/data/models/user_profile_model.dart';
import 'package:tharad/Features/Profile/data/repos/profile_repos.dart';
import 'package:tharad/core/utils/network/api_services.dart';
import 'package:tharad/core/utils/network/error_handler.dart';

class ProfileReposImplementation implements ProfileRepos {
  final ApiService apiService;

  ProfileReposImplementation({required this.apiService});

  @override
  Future<UserProfileResponseModel> getUserProfile() async {
    try {
      final response = await apiService.get(
        endpoint: 'profile-details',
        requiresAuth: true,
      );

      return UserProfileResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      throw ErrorHandler.handleSocketError(e);
    } catch (e) {
      throw ErrorHandler.handleGeneralError(e);
    }
  }

  @override
  Future<UpdateProfileModel> updateProfile({
    required String username,
    required String email,
    String? imagePath,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'username': username,
        'email': email,
        '_method': 'PUT',
      });

      if (imagePath != null && imagePath.isNotEmpty) {
        final file = File(imagePath);
        if (await file.exists()) {
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
      }

      if (password != null && password.isNotEmpty) {
        formData.fields.add(MapEntry('password', password));
      }

      if (newPassword != null && newPassword.isNotEmpty) {
        formData.fields.add(MapEntry('new_password', newPassword));
      }

      if (newPasswordConfirmation != null &&
          newPasswordConfirmation.isNotEmpty) {
        formData.fields.add(
          MapEntry('new_password_confirmation', newPasswordConfirmation),
        );
      }

      final response = await apiService.post(
        endpoint: 'Update-Profile',
        data: formData,
        requiresAuth: true,
      );

      return UpdateProfileModel.fromJson(response);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } on SocketException catch (e) {
      throw ErrorHandler.handleSocketError(e);
    } catch (e) {
      throw ErrorHandler.handleGeneralError(e);
    }
  }
}
