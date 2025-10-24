import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/Widgets/Custom_TextFormField.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isChecked = false;
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _Formkey,
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
                    ),
                    Gap(12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('كلمة المرور ', style: AppStyles.textstyle12),
                    ),
                    Gap(6.h),
                    CustomTextFormField(hint: '**********', ispassword: true),
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
                        Spacer(),
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
                    CustomButtom(
                      text: 'تسجيل الدخول',
                      onTap: () {
                        if (_Formkey.currentState!.validate()) {
                          print('sucsess login');
                        }
                      },
                    ),
                    Gap(8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' ليس لديك حساب؟'),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                          ),
                          onPressed: () {
                            GoRouter.of(context).push('/');
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
        ),
      ),
    );
  }
}
