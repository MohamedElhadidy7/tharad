import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/data/repos/AuthRepos_Implemntation.dart';
import 'package:tharad/Features/Auth/presentation/Views/login_view.dart';
import 'package:tharad/Features/Auth/presentation/Views/otp_verifivation_view.dart';
import 'package:tharad/Features/Auth/presentation/Views/signup_view.dart';
import 'package:tharad/Features/Auth/presentation/manger/LogOut_Cubit/log_out_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/otp_Cubit/otp_verify_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_cubit.dart';
import 'package:tharad/Features/Profile/data/repos/Profile_repos_impl.dart';
import 'package:tharad/Features/Profile/presentation/manger/GetProfileData_Cubit/getprofiledata_cubit.dart';
import 'package:tharad/Features/Profile/presentation/manger/UpdateProfile_Cubit/update_profile_data_cubit.dart';
import 'package:tharad/Features/Profile/presentation/views/profile_view.dart';
import 'package:tharad/core/utils/network/api_services.dart';

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
        path: '/otp-verification',
        builder: (context, state) {
          final data = state.extra as Map<String, String>;
          final email = data['email'] ?? '';
          final password = data['password'] ?? '';

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => VerifyOtpCubit(
                  AuthReposImplementation(apiService: ApiService(Dio())),
                ),
              ),
              BlocProvider(
                create: (context) => LoginCubit(
                  AuthReposImplementation(apiService: ApiService(Dio())),
                ),
              ),
            ],
            child: OtpVerifivationView(email: email, password: password),
          );
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProfileCubit(
                  ProfileReposImplementation(apiService: ApiService(Dio())),
                ),
              ),
              BlocProvider(
                create: (context) => UpdateProfileCubit(
                  ProfileReposImplementation(apiService: ApiService(Dio())),
                ),
              ),
              BlocProvider(
                create: (context) => LogoutCubit(
                  AuthReposImplementation(apiService: ApiService(Dio())),
                ),
              ),
            ],
            child: const ProfileView(),
          );
        },
      ),
    ],
  );
}
