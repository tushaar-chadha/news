import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/screens/mainPage.dart';
import 'package:news/screens/homepage.dart';

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
          home: mainPage(),
        );
      },
    );
  }
}
