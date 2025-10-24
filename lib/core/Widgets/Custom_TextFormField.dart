import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.ispassword,
    this.controller,
  });
  final String hint;
  final bool ispassword;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.ispassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      cursorColor: primaryColor,
      validator: (v) {
        if (v == null || v.isEmpty) {
          return 'please fill the field';
        }
        null;
      },
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xffF0E6DE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xffF0E6DE)),
        ),
        hintText: widget.hint,
        fillColor: Color(0xffF4F7F6),
        suffixIcon: widget.ispassword
            ? GestureDetector(
                onTap: () {
                  _togglePassword();
                },
                child: _obscureText
                    ? Icon(Icons.visibility_off, color: primaryColor)
                    : Icon(Icons.visibility, color: primaryColor),
              )
            : null,
        filled: true,
      ),
    );
  }
}
