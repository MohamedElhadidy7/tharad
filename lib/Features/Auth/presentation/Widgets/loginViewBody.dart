import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/Login_Cubit/login_state.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/Widgets/Custom_TextFormField.dart';
import 'package:tharad/core/utils/helpers/Cache_helper.dart';
import 'package:tharad/core/utils/helpers/validation.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      print('=== Login Button Pressed ===');
      print('Email: ${emailController.text.trim()}');

      context.read<LoginCubit>().login(
        email: emailController.text.trim(),
        password: passController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              print('=== Login Success ===');
              print('Token: ${state.token}');
              print('Username: ${state.username}');

              if (!mounted) return;

              CacheHelper.saveToken(state.token).then((_) {
                print('✅ Token saved successfully!');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${state.message}\nمرحباً ${state.username}!',
                    ),
                    backgroundColor: primaryColor,
                    duration: const Duration(seconds: 2),
                  ),
                );

                Future.microtask(() {
                  if (mounted) {
                    context.go('/profile');
                  }
                });
              });
            } else if (state is LoginFailure) {
              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Gap(120.h),
                        Image.asset('assets/images/tharadlogo.png'),
                        Gap(80.h),
                        Text('تسجيل الدخول', style: AppStyles.textstyle20),
                        Gap(24.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'البريد الإلكتروني',
                            style: AppStyles.textstyle12,
                          ),
                        ),
                        Gap(6.h),
                        CustomTextFormField(
                          hint: 'Tharad@gmail.com',
                          ispassword: false,
                          controller: emailController,
                          validator: AppValidators.validateEmail,
                        ),
                        Gap(12.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'كلمة المرور',
                            style: AppStyles.textstyle12,
                          ),
                        ),
                        Gap(6.h),
                        CustomTextFormField(
                          hint: '**********',
                          ispassword: true,
                          controller: passController,
                          validator: AppValidators.validatePassword,
                        ),

                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  isChecked = val!;
                                });
                              },
                            ),
                            Text(
                              'تذكرني',
                              style: AppStyles.textstyle12.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'هل نسيت كلمه المرور؟',
                                style: AppStyles.textstyle12.copyWith(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(40.h),

                        state is LoginLoading
                            ? CircularProgressIndicator(color: primaryColor)
                            : CustomButtom(
                                text: 'تسجيل الدخول',
                                onTap: _handleLogin,
                              ),
                        Gap(8.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('ليس لديك حساب؟ '),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                              ),
                              onPressed: () {
                                context.push('/signup');
                              },
                              child: Text(
                                'إنشاء حساب جديد',
                                style: AppStyles.textstyle14.copyWith(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(80.h),
                      ],
                    ),
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
