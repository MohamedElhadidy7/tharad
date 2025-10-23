import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/Picked_image_widget.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/Widgets/Custom_TextFormField.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Gap(80.h),
                  Image.asset('assets/images/tharadlogo.png'),
                  Gap(40.h),
                  Text('إنشاء حساب جديد', style: AppStyles.textstyle20),
                  Gap(24.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('الصوره الشخصية', style: AppStyles.textstyle12),
                  ),
                  Gap(6.h),
                  Picked_image_widget(),
                  Gap(12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('إسم المستخدم', style: AppStyles.textstyle12),
                  ),
                  Gap(6.h),
                  CustomTextFormField(hint: 'thar22', ispassword: false),
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
                  ),
                  Gap(12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('كلمة المرور ', style: AppStyles.textstyle12),
                  ),
                  Gap(6.h),
                  CustomTextFormField(hint: '**********', ispassword: true),
                  Gap(12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تأكيد كلمة المرور',
                      style: AppStyles.textstyle12,
                    ),
                  ),
                  Gap(6.h),
                  CustomTextFormField(hint: '**********', ispassword: true),
                  Gap(40.h),
                  CustomButtom(text: 'إنشاء حساب جديد'),
                  Gap(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(' لديك حساب؟'),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                        ),
                        onPressed: () {},
                        child: Text(
                          'تسجيل الدخول',
                          style: AppStyles.textstyle14.copyWith(
                            color: primaryColor,
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
    );
  }
}
