import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Auth/data/repos/Authrepos.dart';
import 'package:tharad/Features/Auth/presentation/manger/LogOut_Cubit/log_out_state.dart';
import 'package:tharad/core/utils/helpers/Cache_helper.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepos authRepos;

  LogoutCubit(this.authRepos) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final response = await authRepos.logoutService();

      await CacheHelper.clearAll();

      emit(LogoutSuccess(response.message));
    } catch (e) {
      await CacheHelper.clearAll();

      emit(LogoutSuccess('تم تسجيل الخروج بنجاح'));
    }
  }
}
