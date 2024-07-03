// ignore_for_file: use_super_parameters

import 'package:ecommerce_app/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false, home: SplashScreen()),
      designSize: const Size(360, 640),
    );
  }
}
