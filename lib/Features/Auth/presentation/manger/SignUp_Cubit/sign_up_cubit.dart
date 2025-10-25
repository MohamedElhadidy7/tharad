// Features/Auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Auth/data/repos/Authrepos.dart';

import 'package:tharad/Features/Auth/presentation/manger/SignUp_Cubit/sign_up_state.dart';

import 'package:tharad/core/utils/network/exceptions.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepos authRepos;

  SignUpCubit(this.authRepos) : super(SignUpInitial());

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String? imagePath,
  }) async {
    emit(SignUpLoading());

    try {
      final response = await authRepos.signUpService(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        imagePath: imagePath,
      );
      emit(
        SignUpSuccess(
          message: response.message,
          email: response.data?.email ?? '',
          username: response.data?.username ?? '',
          imageUrl: response.data?.image ?? '',
          otp: response.data?.otp ?? 0,
        ),
      );
    } on ValidationException catch (e) {
      emit(SignUpFailure(e.message));
    } on NetworkException catch (e) {
      emit(SignUpFailure(e.message));
    } on ServerException catch (e) {
      emit(SignUpFailure(e.message));
    } catch (e, stackTrace) {
      emit(SignUpFailure('حدث خطأ غير متوقع: $e'));
    }
  }
}
