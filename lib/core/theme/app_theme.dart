import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.background,

  colorScheme: ColorScheme.light(
    primary: AppColors.fireRed,
    secondary: AppColors.retroGreen,
    surface: AppColors.card,
    error: AppColors.error,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.vanillaCream,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
  ),
);
}