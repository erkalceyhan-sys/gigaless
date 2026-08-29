import 'package:flutter/material.dart';

class AppColors {
  // Obsidian Dark Theme
  static const Color darkBackground = Color(0xFF090A0C);
  static const Color darkCard = Color(0xFF14161A);
  static const Color darkCardBorder = Color(0xFF22262E);
  static const Color darkSurface = Color(0xFF1B1E24);
  
  // Pearl Light Theme
  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardBorder = Color(0xFFE5E7EB);
  static const Color lightSurface = Color(0xFFEEF0F4);

  // Accents & Signals
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color trashCoral = Color(0xFFFF3B30);
  static const Color keepEmerald = Color(0xFF34C759);
  static const Color reviewAmber = Color(0xFFFF9500);

  // Text
  static const Color textDarkPrimary = Color(0xFFF9FAFB);
  static const Color textDarkSecondary = Color(0xFF9CA3AF);
  static const Color textLightPrimary = Color(0xFF111827);
  static const Color textLightSecondary = Color(0xFF6B7280);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primaryBlue,
      cardColor: AppColors.darkCard,
      dividerColor: AppColors.darkCardBorder,
      fontFamily: 'SF Pro Display',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textDarkPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textDarkPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBlue,
        surface: AppColors.darkSurface,
        error: AppColors.trashCoral,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primaryBlue,
      cardColor: AppColors.lightCard,
      dividerColor: AppColors.lightCardBorder,
      fontFamily: 'SF Pro Display',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textLightPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textLightPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.4,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        surface: AppColors.lightSurface,
        error: AppColors.trashCoral,
      ),
    );
  }
}
