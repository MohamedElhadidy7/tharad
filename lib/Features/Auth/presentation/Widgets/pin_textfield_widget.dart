import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tharad/constants.dart';

class PinTextField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  const PinTextField({
    super.key,
    this.controller,
    required this.onChanged,
    this.onCompleted,
  });

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        controller: _controller,
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
        onChanged: widget.onChanged,
        onCompleted: widget.onCompleted,
        textStyle: const TextStyle(fontSize: 20),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
