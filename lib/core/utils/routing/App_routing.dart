import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/Views/login_view.dart';
import 'package:tharad/Features/Auth/presentation/Views/otp_verifivation_view.dart';
import 'package:tharad/Features/Auth/presentation/Views/signup_view.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SignupView();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          return const OtpVerifivationView();
        },
      ),
    ],
  );
}
