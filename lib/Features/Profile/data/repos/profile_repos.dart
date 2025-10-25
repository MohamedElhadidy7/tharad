import 'package:tharad/Features/Auth/data/models/logOut_model.dart';
import 'package:tharad/Features/Profile/data/models/update_profile_model.dart';
import 'package:tharad/Features/Profile/data/models/user_profile_model.dart';

abstract class ProfileRepos {
  Future<UserProfileResponseModel> getUserProfile();

  Future<UpdateProfileModel> updateProfile({
    required String username,
    required String email,
    String? imagePath,
    String? password,
    String? newPassword,
    String? newPasswordConfirmation,
  });
}
