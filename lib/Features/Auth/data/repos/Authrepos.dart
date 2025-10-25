import 'package:tharad/Features/Auth/data/models/sign_up_model.dart';

abstract class AuthRepos {
  Future<RegistrationResponseModel> signUpService({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String? imagePath,
  });
}
