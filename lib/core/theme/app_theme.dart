import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Cairo',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        secondary: AppColors.teal,
        error: AppColors.error,
        surface: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontSize: 24.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray900),
        displayMedium: TextStyle(
            fontSize: 20.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray900),
        displaySmall: TextStyle(
            fontSize: 18.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray900),
        bodyLarge: TextStyle(fontSize: 16.SP, color: AppColors.gray700),
        bodyMedium: TextStyle(fontSize: 14.SP, color: AppColors.gray700),
        bodySmall: TextStyle(fontSize: 12.SP, color: AppColors.gray500),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            fontSize: 24.SP, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 56.H),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.R),
          ),
          textStyle: TextStyle(fontSize: 18.SP, fontWeight: FontWeight.bold),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray50,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.W, vertical: 16.H),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.R),
          borderSide: const BorderSide(color: AppColors.gray200, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.R),
          borderSide: const BorderSide(color: AppColors.gray200, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.R),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
      ),
    );
  }
}
