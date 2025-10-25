import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad/constants.dart';

class PinTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  const PinTextField({super.key, this.onChanged, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
        onChanged: onChanged ?? (value) {},
        onCompleted: onCompleted,
        textStyle: const TextStyle(fontSize: 20),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        animationType: AnimationType.fade,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: false,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 49,
          fieldWidth: 49,
          activeColor: primaryColor,
          selectedColor: primaryColor,
          inactiveColor: const Color(0xffF0E6DE),
          activeFillColor: Colors.white,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
        ),
      ),
    );
  }
}
