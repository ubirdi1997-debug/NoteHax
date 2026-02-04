import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notehax/constants/app_constants.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonBlue,
        secondary: AppColors.neonGreen,
        tertiary: AppColors.neonPurple,
        surface: AppColors.secondaryDark,
        error: AppColors.error,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      
      // Text Theme
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: AppTextStyles.heading1,
          displayMedium: AppTextStyles.heading2,
          displaySmall: AppTextStyles.heading3,
          bodyLarge: AppTextStyles.body,
          bodyMedium: AppTextStyles.bodySecondary,
          bodySmall: AppTextStyles.caption,
        ),
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      
      // Card Theme
      cardTheme: const CardThemeData(
        color: AppColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.medium,
          side: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.neonBlue,
        foregroundColor: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.medium,
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondaryDark,
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.medium,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.medium,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.medium,
          borderSide: BorderSide(color: AppColors.neonBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.medium,
          borderSide: BorderSide(color: AppColors.error),
        ),
        contentPadding: EdgeInsets.all(AppSpacing.md),
        hintStyle: TextStyle(color: AppColors.textTertiary),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: 24,
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.borderColor,
        thickness: 1,
        space: 1,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.secondaryDark,
        selectedItemColor: AppColors.neonBlue,
        unselectedItemColor: AppColors.textTertiary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Dialog Theme
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.secondaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.large,
        ),
        elevation: 8,
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.secondaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        elevation: 8,
      ),
      
      // Chip Theme
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.tertiaryDark,
        labelStyle: TextStyle(color: AppColors.textPrimary),
        side: BorderSide(color: AppColors.borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.medium,
        ),
      ),
    );
  }
}
