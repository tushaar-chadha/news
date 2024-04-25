import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/screens/mainPage.dart';
import 'package:news/screens/homepage.dart';
import 'package:news/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 690),
      builder: (_, __) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              textTheme: Typography.englishLike2021.apply(fontSizeFactor: 1.sp),
            ),
            home: AnimatedSplashScreen(
                duration: 1500,
                splash: Text(
                  "Bulletin News",
                  style: montserratTextStyle(
                      AppColors.blackColor, 40.sp, FontWeight.bold),
                ),
                nextScreen: mainPage(),
                curve: Curves.easeIn,
                animationDuration: Duration(seconds: 2),
                centered: true,
                splashTransition: SplashTransition.fadeTransition,
                backgroundColor: AppColors.backgroundColor));
      },
    );
  }
}
