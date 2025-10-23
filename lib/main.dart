import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad/Features/Auth/presentation/Views/signup_view.dart';

void main() {
  runApp(const Tharad());
}

class Tharad extends StatelessWidget {
  const Tharad({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tharad App',
          theme: ThemeData(fontFamily: 'Tajawal'),
          home: Directionality(textDirection: TextDirection.rtl, child: child!),
        );
      },
      child: const SignupView(),
    );
  }
}
