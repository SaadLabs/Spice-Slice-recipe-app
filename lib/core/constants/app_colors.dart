import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color fireRed = Color(0xFFD23D2D);
  static const Color retroGreen = Color(0xFF31603D);
  static const Color vanillaCream = Color(0xFFFFFBF2);
  static const Color saffron = Color(0xFFF5C065);
  static const Color russet = Color(0xFF6E433D);

  // Backgrounds
  static const Color background = vanillaCream;
  static const Color card = Colors.white;

  // Text
  static const Color textPrimary = Color(0xFF2B2F33);
  static const Color textSecondary = Color(0xFF6F757C);

  // Borders
  static const Color border = Color(0xFFE2D9BE);
  static const Color divider = Color(0xFFE8DFC5);

  // Status
  static const Color success = retroGreen;
  static const Color error = fireRed;
  static const Color warning = saffron;

  // Navigation
  static const Color navSelected = fireRed;
  static const Color navUnselected = textSecondary;
  static const Color navIndicator = saffron;
}
