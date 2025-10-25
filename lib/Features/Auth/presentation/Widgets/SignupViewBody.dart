import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/Picked_image_widget.dart';
import 'package:tharad/Features/Auth/presentation/manger/SignUp_Cubit/sign_up_cubit.dart';
import 'package:tharad/Features/Auth/presentation/manger/SignUp_Cubit/sign_up_state.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/Widgets/Custom_TextFormField.dart';
import 'package:tharad/core/utils/helpers/validation.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _imagePath;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmpassController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passController.text,
        confirmPassword: confirmpassController.text,
        imagePath: _imagePath,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              print('=== Sign Up Success ===');
              print('Email: ${state.email}');
              print('OTP: ${state.otp}');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: primaryColor,
                  duration: const Duration(seconds: 2),
                ),
              );

              GoRouter.of(
                context,
              ).go('/otp', extra: {'email': state.email, 'otp': state.otp});
            } else if (state is SignUpFailure) {
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
                        Gap(80.h),
                        Image.asset('assets/images/tharadlogo.png'),
                        Gap(40.h),
                        Text('إنشاء حساب جديد', style: AppStyles.textstyle20),
                        Gap(24.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الصوره الشخصية',
                            style: AppStyles.textstyle12,
                          ),
                        ),
                        Gap(6.h),
                        PickedImageWidget(
                          onImagePicked: (imagePath) {
                            setState(() {
                              _imagePath = imagePath;
                            });
                          },
                        ),
                        Gap(12.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'إسم المستخدم',
                            style: AppStyles.textstyle12,
                          ),
                        ),
                        Gap(6.h),
                        CustomTextFormField(
                          hint: 'thar22',
                          ispassword: false,
                          controller: usernameController,
                          validator: AppValidators.validateUsername,
                        ),
                        Gap(12.h),

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
                            'كلمة المرور ',
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
                        Gap(12.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'تأكيد كلمة المرور',
                            style: AppStyles.textstyle12,
                          ),
                        ),
                        Gap(6.h),
                        CustomTextFormField(
                          hint: '**********',
                          ispassword: true,
                          controller: confirmpassController,
                          validator: (value) =>
                              AppValidators.validateConfirmPassword(
                                value,
                                passController.text,
                              ),
                        ),
                        Gap(40.h),

                        state is SignUpLoading
                            ? CircularProgressIndicator(color: primaryColor)
                            : CustomButtom(
                                text: 'إنشاء حساب جديد',
                                onTap: _handleSignUp,
                              ),
                        Gap(8.h),

                        // رابط تسجيل الدخول
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(' لديك حساب؟'),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                              ),
                              onPressed: () {
                                GoRouter.of(context).push('/login');
                              },
                              child: Text(
                                'تسجيل الدخول',
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
