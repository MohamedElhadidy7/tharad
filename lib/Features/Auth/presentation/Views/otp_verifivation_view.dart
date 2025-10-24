import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/pin_textfield_widget.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/resend_widget.dart';

import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class OtpVerifivationView extends StatefulWidget {
  const OtpVerifivationView({super.key});

  @override
  State<OtpVerifivationView> createState() => _OtpVerifivationViewState();
}

class _OtpVerifivationViewState extends State<OtpVerifivationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                child: const PinTextField(),
              ),
              ResendWidget(),
              Gap(40.h),
              CustomButtom(text: 'المتابعه'),
            ],
          ),
        ),
      ),
    );
  }
}
