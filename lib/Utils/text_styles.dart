import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColors.blackColor,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.greyColor,
  );

  static const TextStyle normalText = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.primaryColor,
  );
}
