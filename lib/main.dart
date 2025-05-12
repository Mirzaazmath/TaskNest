import 'package:flutter/material.dart';
import 'package:task_nest/constants/app_colors.dart';
import 'package:task_nest/screens/splash_screen.dart';
import 'package:task_nest/utils/shared_prefutils.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  // Here we are initializing the SharedPreferences
  SharedPrefUtils().initSharedPref();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColorDark,
        primaryColorLight: AppColors.primaryColorLight,
        scaffoldBackgroundColor: AppColors.backgroundColor
      ),

      home: const SplashScreen(),

    );
  }
}
