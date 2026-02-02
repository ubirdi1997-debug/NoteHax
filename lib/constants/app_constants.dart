import 'package:flutter/material.dart';

// App Information
class AppConstants {
  static const String appName = 'NoteHax';
  static const String packageName = 'com.notehax.usafe';
  static const String version = '1.0.0';
  static const String company = 'Geometic Eduservices Private Limited';
  static const String supportEmail = 'notehax.aarav@gmail.com';
  static const String tagline = 'Smart Hacker Notebook';
}

// Theme Colors
class AppColors {
  // Dark Theme Base
  static const Color primaryDark = Color(0xFF0A0A0A);
  static const Color secondaryDark = Color(0xFF1E1E1E);
  static const Color tertiaryDark = Color(0xFF2A2A2A);
  
  // Neon Accents
  static const Color neonBlue = Color(0xFF00F0FF);
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonPurple = Color(0xFFB400FF);
  static const Color neonPink = Color(0xFFFF00E5);
  
  // UI Elements
  static const Color cardDark = Color(0xFF1A1A1A);
  static const Color borderColor = Color(0xFF333333);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Status Colors
  static const Color success = Color(0xFF00FF88);
  static const Color error = Color(0xFFFF3366);
  static const Color warning = Color(0xFFFFAA00);
  static const Color info = Color(0xFF00F0FF);
  
  // Note Colors
  static const List<Color> noteColors = [
    Color(0xFF1E1E1E),  // Default
    Color(0xFF2D1B2E),  // Purple
    Color(0xFF1B2D2D),  // Teal
    Color(0xFF2D2D1B),  // Yellow
    Color(0xFF2D1B1B),  // Red
    Color(0xFF1B2D1B),  // Green
    Color(0xFF1B1B2D),  // Blue
  ];
}

// Hive Box Names
class HiveBoxes {
  static const String notes = 'notes';
  static const String settings = 'settings';
  static const String security = 'security';
}

// Storage Keys
class StorageKeys {
  static const String pin = 'user_pin';
  static const String biometricsEnabled = 'biometrics_enabled';
  static const String themeMode = 'theme_mode';
  static const String lastBackup = 'last_backup';
  static const String firstLaunch = 'first_launch';
}

// Animation Durations
class AnimationDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

// Text Styles
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textTertiary,
  );
}

// Border Radius
class AppBorderRadius {
  static const BorderRadius small = BorderRadius.all(Radius.circular(8));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(12));
  static const BorderRadius large = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(24));
}

// Spacing
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
