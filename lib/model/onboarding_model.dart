import 'package:flutter/material.dart';
import 'package:task_nest/constants/app_strings.dart';

import '../constants/app_colors.dart';

class OnboardingModel {
  final String image;
  final String title;
  final Color backgroundColor;
  final Color currentCircleColor;
  final Color nextCircleColor;
  final Color? textColor;
  OnboardingModel(
      {required this.backgroundColor,
      required this.nextCircleColor,
      required this.currentCircleColor,
      required this.image,
      required this.title,
      this.textColor});
}

List<OnboardingModel> onboardingDataList = [
  OnboardingModel(
      backgroundColor: AppColors.backgroundColor,
      nextCircleColor: AppColors.backgroundColor,
      currentCircleColor: AppColors.primaryColor,
      image: AppStrings.onboardingImagePlan,
      title: AppStrings.onboardingText1),
  OnboardingModel(
      backgroundColor: AppColors.primaryColor,
      nextCircleColor: AppColors.backgroundColor,
      currentCircleColor: AppColors.backgroundColor,
      image: AppStrings.onboardingImageComplete,
      title: AppStrings.onboardingText2,
      textColor: AppColors.backgroundColor),
  OnboardingModel(
      backgroundColor: AppColors.backgroundColor,
      nextCircleColor: AppColors.primaryColor,
      currentCircleColor: AppColors.primaryColor,
      image: AppStrings.onboardingImageSuccess,
      title: AppStrings.onboardingText3),
];
