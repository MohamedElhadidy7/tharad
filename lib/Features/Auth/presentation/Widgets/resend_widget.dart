import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad/constants.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class ResendWidget extends StatefulWidget {
  const ResendWidget({super.key});

  @override
  State<ResendWidget> createState() => _ResendWidgetState();
}

class _ResendWidgetState extends State<ResendWidget> {
  int remainingSeconds = 0;
  Timer? timer;
  bool canResend = true; // في الأول الزر مفعل والعداد مش ظاهر

  void startTimer() {
    setState(() {
      remainingSeconds = 60;
      canResend = false;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds == 0) {
        t.cancel();
        setState(() {
          canResend = true;
        });
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // 👇 العداد يظهر فقط لما يكون شغال
          if (!canResend)
            Text(
              ' 00:${remainingSeconds.toString().padLeft(2, '0')} Sec',
              style: AppStyles.textstyle12.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          const Spacer(),
          Row(
            children: [
              Text('لم يصلك رمز؟', style: AppStyles.textstyle12),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                ),
                onPressed: canResend
                    ? () {
                        startTimer();
                      }
                    : null,
                child: Text(
                  'إعادة إرسال',
                  style: AppStyles.textstyle12.copyWith(
                    color: canResend
                        ? primaryColor // لما الزر مفعل → لونه الأساسي
                        : Colors.grey, // لما العدّاد شغال → رمادي
                    decoration: TextDecoration.underline,
                    decorationColor: canResend ? primaryColor : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
