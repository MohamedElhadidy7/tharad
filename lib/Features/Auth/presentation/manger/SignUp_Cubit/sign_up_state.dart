abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;
  final String email;
  final String username;
  final String imageUrl;
  final int otp;

  SignUpSuccess({
    required this.message,
    required this.email,
    required this.username,
    required this.imageUrl,
    required this.otp,
  });
}

class SignUpFailure extends SignUpState {
  final String errorMessage;

  SignUpFailure(this.errorMessage);
}
