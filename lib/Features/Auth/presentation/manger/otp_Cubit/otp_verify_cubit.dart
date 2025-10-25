import 'package:bloc/bloc.dart';
import 'package:tharad/Features/Auth/data/repos/Authrepos.dart';
import 'package:tharad/Features/Auth/presentation/manger/otp_Cubit/otp_verify_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final AuthRepos authRepos;

  VerifyOtpCubit(this.authRepos) : super(VerifyOtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(VerifyOtpLoading());
    try {
      final response = await authRepos.verifyOtpService(email: email, otp: otp);

      emit(
        VerifyOtpSuccess(message: response.message, status: response.status),
      );
    } catch (error) {
      emit(VerifyOtpFailure(error.toString()));
    }
  }
}
