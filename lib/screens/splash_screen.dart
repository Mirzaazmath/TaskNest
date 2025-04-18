import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_nest/constants/app_strings.dart';
import 'package:task_nest/utils/show_animation_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShowUpAnimation(
            child: Text(AppStrings.appName, style: GoogleFonts.dancingScript(textStyle: Theme.of(context).textTheme.displayLarge,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor) ,)),
      ),

    );
  }
}
