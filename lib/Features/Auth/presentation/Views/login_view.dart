import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Auth/data/repos/AuthRepos_Implemntation.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/loginViewBody.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_cubit.dart';
import 'package:tharad/core/utils/network/api_services.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(AuthReposImplementation(apiService: ApiService(Dio()))),
      child: const LoginViewBody(),
    );
  }
}
