import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/pin_textfield_widget.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/resend_widget.dart';
import 'package:tharad/Features/Auth/presentation/manger/otp_Cubit/otp_verify_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/otp_Cubit/otp_verify_state.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_state.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/utils/helpers/Cache_helper.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class OtpVerifivationView extends StatefulWidget {
  final String email;
  final String password;

  const OtpVerifivationView({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<OtpVerifivationView> createState() => _OtpVerifivationViewState();
}

class _OtpVerifivationViewState extends State<OtpVerifivationView> {
  String enteredOtp = '';

  void _handleVerifyOtp(BuildContext context) {
    if (enteredOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك أدخل رمز التحقق'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (enteredOtp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('رمز التحقق يجب أن يكون 4 أرقام'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    context.read<VerifyOtpCubit>().verifyOtp(
      email: widget.email,
      otp: enteredOtp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<VerifyOtpCubit, VerifyOtpState>(
            listener: (context, state) {
              if (state is VerifyOtpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'تم التحقق بنجاح! جاري تسجيل الدخول...',
                    ),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 2),
                  ),
                );

                FocusScope.of(context).unfocus();
                Future.delayed(const Duration(milliseconds: 1500), () {
                  if (context.mounted) {
                    context.read<LoginCubit>().login(
                      email: widget.email,
                      password: widget.password,
                    );
                  }
                });
              } else if (state is VerifyOtpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),

          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                CacheHelper.saveToken(state.token).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('مرحباً ${state.username}! 🎉'),
                      backgroundColor: primaryColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );

                  Future.microtask(() {
                    if (context.mounted) {
                      context.go('/profile');
                    }
                  });
                });
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
          builder: (context, state) {
            final isLoading = state is VerifyOtpLoading;

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(120.h),
                      Image.asset('assets/images/tharadlogo.png'),
                      Gap(100.h),
                      Text('رمز التحقق', style: AppStyles.textstyle20),
                      Gap(8.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الإلكتروني',
                          style: AppStyles.textstyle12.copyWith(
                            color: const Color(0xff998C8C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(40.h),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: PinTextField(
                          onCompleted: (code) {
                            setState(() => enteredOtp = code);
                          },
                          onChanged: (code) {
                            enteredOtp = code;
                          },
                        ),
                      ),

                      Gap(24.h),

                      const ResendWidget(),

                      Gap(40.h),

                      isLoading
                          ? CircularProgressIndicator(color: primaryColor)
                          : CustomButtom(
                              text: 'المتابعه',
                              onTap: () => _handleVerifyOtp(context),
                            ),

                      Gap(40.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
