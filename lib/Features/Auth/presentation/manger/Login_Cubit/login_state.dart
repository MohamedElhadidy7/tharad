// Features/Auth/presentation/manger/login_cubit/login_state.dart

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;
  final String token;
  final String username;
  final String email;

  LoginSuccess({
    required this.message,
    required this.token,
    required this.username,
    required this.email,
  });
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}
