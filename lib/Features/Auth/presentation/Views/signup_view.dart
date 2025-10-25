import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad/Features/Auth/data/repos/AuthRepos_Implemntation.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/SignUpViewBody.dart';
import 'package:tharad/Features/Auth/presentation/manger/SignUp_Cubit/sign_up_cubit.dart';
import 'package:tharad/core/utils/network/api_services.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpCubit(AuthReposImplementation(apiService: ApiService(Dio()))),
      child: const SignupViewBody(),
    );
  }
}
