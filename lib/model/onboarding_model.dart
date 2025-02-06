import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class OnboardingModel{
  final String image;
  final String title;
  final Color backgroundColor;
  final Color currentCircleColor;
  final Color nextCircleColor;
  final Color? textColor;
  OnboardingModel({
    required this.backgroundColor,
    required this.nextCircleColor,
    required this.currentCircleColor,
    required this.image,
    required this.title,
    this.textColor
  });
}
List<OnboardingModel>onboardingDataList=[
 OnboardingModel(backgroundColor:  AppColors.backgroundColor, nextCircleColor:AppColors.backgroundColor, currentCircleColor: AppColors.primaryColor, image: "assets/images/planing.png", title: "Welcome! 🎉\n Plan smarter, stay organized."),
  OnboardingModel(backgroundColor:  AppColors.primaryColor, nextCircleColor:AppColors.backgroundColor, currentCircleColor: AppColors.backgroundColor, image: "assets/images/complete.png", title: "Turn your plans into reality stay focused.",textColor: AppColors.backgroundColor),
  OnboardingModel(backgroundColor:  AppColors.backgroundColor, nextCircleColor:AppColors.primaryColor, currentCircleColor: AppColors.primaryColor, image: "assets/images/success.png", title: "Every step forward brings you closer to success"),

];