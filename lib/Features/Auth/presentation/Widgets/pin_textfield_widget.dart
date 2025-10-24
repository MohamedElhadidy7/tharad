import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad/constants.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({super.key});
  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  final TextEditingController otpcontroller = TextEditingController();
  @override
  void dispose() {
    otpcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        enablePinAutofill: true,
        length: 4,
        controller: otpcontroller,
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
          inactiveColor: Color(0xffF0E6DE),
          activeFillColor: Colors.white,
        ),
      ),
    );
  }
}
