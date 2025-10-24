import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class OtpVerifivationView extends StatefulWidget {
  const OtpVerifivationView({super.key});

  @override
  State<OtpVerifivationView> createState() => _OtpVerifivationViewState();
}

class _OtpVerifivationViewState extends State<OtpVerifivationView> {
  TextEditingController otpcontroller = TextEditingController();
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
              Text('  رمز التحقق', style: AppStyles.textstyle20),
              Gap(8.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '  لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الإلكتروني',
                  style: AppStyles.textstyle12.copyWith(
                    color: Color(0xff998C8C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(40.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  length: 4,
                  controller: otpcontroller,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {},
                  textStyle: const TextStyle(fontSize: 20),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,

                    borderRadius: BorderRadius.circular(16),
                    fieldHeight: 49,
                    fieldWidth: 49,
                    activeColor: primaryColor,
                    selectedColor: primaryColor,
                    inactiveColor: Color(0xffF0E6DE),
                    activeFillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
