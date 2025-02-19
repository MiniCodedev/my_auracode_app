import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed: AppColors.primaryColor,
    brightness: Brightness.dark,
    useMaterial3: true,
  );

  static BoxDecoration themeBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
    colors: [
      AppColors.primaryColor,
      darkTheme.cardColor,
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ));
}
