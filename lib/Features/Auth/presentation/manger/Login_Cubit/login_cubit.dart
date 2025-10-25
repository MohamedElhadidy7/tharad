import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Auth/data/repos/Authrepos.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_state.dart';
import 'package:tharad/core/utils/helpers/Cache_helper.dart';
import 'package:tharad/core/utils/network/exceptions.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepos authRepos;

  LoginCubit(this.authRepos) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final response = await authRepos.loginService(
        email: email,
        password: password,
      );

      final token = response.data?.token ?? '';
      final username = response.data?.username ?? '';
      final userEmail = response.data?.email ?? email;

      if (token.isEmpty) {
        emit(LoginFailure('حدث خطأ: لم يتم استلام رمز التوثيق'));
        return;
      }

      await CacheHelper.saveUserProfile({
        'username': username,
        'email': userEmail,
        'image': null,
      });

      emit(
        LoginSuccess(
          message: response.message,
          token: token,
          username: username,
          email: userEmail,
        ),
      );
    } on ValidationException catch (e) {
      emit(LoginFailure(e.message));
    } on NetworkException catch (e) {
      emit(LoginFailure(e.message));
    } on ServerException catch (e) {
      emit(LoginFailure(e.message));
    } catch (e, stackTrace) {
      emit(LoginFailure('حدث خطأ غير متوقع: $e'));
    }
  }
}
