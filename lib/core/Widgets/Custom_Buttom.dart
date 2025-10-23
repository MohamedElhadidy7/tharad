import 'package:flutter/material.dart';
import 'package:tharad/core/utils/styles/app_styles.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key, this.onTap, required this.text});
  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff5CC7A3), Color(0xff265355)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.textstyle14.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
