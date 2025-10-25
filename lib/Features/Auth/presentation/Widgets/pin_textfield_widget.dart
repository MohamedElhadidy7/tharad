import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad/constants.dart';

class PinTextField extends StatelessWidget {
  final TextEditingController controller; // ✅ نستقبل الـ controller من برة

  const PinTextField({
    super.key,
    required this.controller, // ✅ مطلوب
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        enablePinAutofill: true,
        length: 4,
        controller: controller, // ✅ استخدام الـ controller اللي جاي من برة
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
        onChanged: (v) {},
        textStyle: const TextStyle(fontSize: 20),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 49,
          fieldWidth: 49,
          activeColor: primaryColor,
          selectedColor: primaryColor,
          inactiveColor: const Color(0xffF0E6DE),
          activeFillColor: Colors.white,
        ),
      ),
    );
  }
}
