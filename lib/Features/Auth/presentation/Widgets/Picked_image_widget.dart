import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad/constants.dart';

class Picked_image_widget extends StatelessWidget {
  const Picked_image_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(16),
        dashPattern: [10, 5],
        strokeWidth: 1,
        color: primaryColor,
      ),
      child: Container(
        height: 110.h,
        width: 350.w,
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xffF4F7F6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/camera.png', width: 24.w, height: 24.h),
            Gap(6.h),
            Text('الملفات المسموح بيها:JPEG , PNG'),
            Text('الحد الاقصي : 5MB'),
          ],
        ),
      ),
    );
  }
}
