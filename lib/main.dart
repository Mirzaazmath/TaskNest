import 'package:flutter/material.dart';
import 'package:task_nest/screens/onBoardingScreen/on_boarding_screen.dart';
void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  const MaterialApp(
      home: OnBoardingScreen(),

    );
  }
}
