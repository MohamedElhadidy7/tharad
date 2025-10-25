import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/Views/login_view.dart';
import 'package:tharad/Features/Auth/presentation/Views/otp_verifivation_view.dart';
import 'package:tharad/Features/Auth/presentation/Views/signup_view.dart';
import 'package:tharad/Features/Profile/presentation/views/profile_view.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          return const SignupView();
        },
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          if (extra == null ||
              !extra.containsKey('email') ||
              !extra.containsKey('otp')) {
            return const SignupView();
          }
          return OtpVerifivationView(
            email: extra['email'] as String,
            otp: extra['otp'] as int,
          );
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          return const ProfileView();
        },
      ),
    ],
  );
}
