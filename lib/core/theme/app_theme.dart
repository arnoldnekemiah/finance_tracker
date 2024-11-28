import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB38B2D);
  static const Color lightGold = Color(0xFFE5C365);

  // Black Shades
  static const Color richBlack = Color(0xFF0D0D0D);
  static const Color charcoal = Color(0xFF2D2D2D);
  static const Color gunmetal = Color(0xFF2C3539);

  // Blue Accents
  static const Color midnightBlue = Color(0xFF145DA0);
  static const Color darkBlue = Color(0xFF0C2D48);
  static const Color lightBlue = Color(0xFF2E8BC0);

  // Supporting Colors
  static const Color white = Color(0xFFFAF9F6);
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryGold,
        secondary: AppColors.midnightBlue,
        surface: AppColors.white,
        background: Colors.white,
        error: AppColors.error,
        onPrimary: AppColors.richBlack,
        onSecondary: AppColors.white,
        onSurface: AppColors.richBlack,
        onBackground: AppColors.richBlack,
        onError: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.richBlack,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.lightGold.withOpacity(0.2)),
        ),
        color: AppColors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.richBlack,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightGold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryGold, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.darkGold,
        secondary: AppColors.darkBlue,
        surface: AppColors.charcoal,
        background: AppColors.richBlack,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
        onBackground: AppColors.white,
        onError: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.gunmetal,
        foregroundColor: AppColors.primaryGold,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.darkGold.withOpacity(0.2)),
        ),
        color: AppColors.charcoal,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkGold,
        foregroundColor: AppColors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkGold),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryGold, width: 2),
        ),
        filled: true,
        fillColor: AppColors.gunmetal,
      ),
    );
  }
}
