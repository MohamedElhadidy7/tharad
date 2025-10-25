import 'package:tharad/Features/Auth/data/models/logOut_model.dart';
import 'package:tharad/Features/Auth/data/models/login_model.dart';
import 'package:tharad/Features/Auth/data/models/logout_model.dart';
import 'package:tharad/Features/Auth/data/models/sign_up_model.dart';
import 'package:tharad/Features/Auth/data/models/otp_model.dart';

abstract class AuthRepos {
  Future<RegistrationResponseModel> signUpService({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String? imagePath,
  });

  Future<LoginResponseModel> loginService({
    required String email,
    required String password,
  });

  Future<VerifyOtpModel> verifyOtpService({
    required String email,
    required String otp,
  });

  Future<LogoutModel> logoutService();
}
