abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final String message;
  final String status;

  VerifyOtpSuccess({required this.message, required this.status});
}

class VerifyOtpFailure extends VerifyOtpState {
  final String errorMessage;

  VerifyOtpFailure(this.errorMessage);
}
