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
  int remainingSeconds = 59;
  Timer? timer;
  bool isCounting = false;

  void startTimer() {
    setState(() {
      isCounting = true;
      remainingSeconds = 59;
    });

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds == 0) {
        t.cancel();
        setState(() {
          isCounting = false;
        });
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
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
          Text(
            ' ${formatTime(remainingSeconds)} Sec',
            style: AppStyles.textstyle12.copyWith(
              color: isCounting ? primaryColor : Colors.grey,
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
                onPressed: isCounting
                    ? null
                    : () {
                        startTimer();
                      },
                child: Text(
                  'إعادة إرسال',
                  style: AppStyles.textstyle12.copyWith(
                    color: isCounting ? Colors.grey : primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: isCounting ? Colors.grey : primaryColor,
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
