// Features/Auth/presentation/views/otp_verification_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/pin_textfield_widget.dart';
import 'package:tharad/Features/Auth/presentation/Widgets/resend_widget.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/Widgets/Custom_Buttom.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class OtpVerifivationView extends StatefulWidget {
  final String email;
  final int otp;

  const OtpVerifivationView({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<OtpVerifivationView> createState() => _OtpVerifivationViewState();
}

class _OtpVerifivationViewState extends State<OtpVerifivationView> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _handleVerifyOtp() {
    if (otpController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك أدخل رمز التحقق'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (otpController.text.trim().length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('رمز التحقق يجب أن يكون 4 أرقام'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });

      if (otpController.text.trim() == widget.otp.toString()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم التحقق بنجاح! يمكنك الآن تسجيل الدخول'),
            backgroundColor: primaryColor,
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          GoRouter.of(context).go('/login');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('رمز التحقق غير صحيح. حاول مرة أخرى'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  child: PinTextField(controller: otpController),
                ),
                Gap(24.h),
                const ResendWidget(),
                Gap(40.h),
                isLoading
                    ? CircularProgressIndicator(color: primaryColor)
                    : CustomButtom(text: 'المتابعه', onTap: _handleVerifyOtp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
