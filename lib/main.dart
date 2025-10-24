import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad/core/utils/routing/app_routing.dart';

void main() {
  runApp(const TharadApp());
}

class TharadApp extends StatelessWidget {
  const TharadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Tharad App',
          theme: ThemeData(fontFamily: 'Tajawal'),
          routerConfig: AppRouter.router,

          locale: const Locale('ar', 'EG'),
          supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // 👇 مهم جدًا عشان الاتجاه يفضل RTL في كل الصفحات
          builder: (context, child) {
            ScreenUtil.init(context);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
        );
      },
    );
  }
}
