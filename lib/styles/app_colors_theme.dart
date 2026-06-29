import "package:flutter/material.dart" show Color;
import "package:flutter_first_app/styles/app_colors_all.dart" show AppColors;
import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode;

class AppThemeColors {
  final AppAvailableThemeMode themeMode;

  final Color primary;
  final Color primaryContrast;
  final Color background;
  final Color backgroundInverted;
  final Color border;
  final Color borderInverted;
  final Color shadow;
  final Color shadowInverted;
  final Color text;
  final Color textInverted;
  final Color danger;
  final Color dangerContrast;

  const AppThemeColors({
    required this.themeMode,
    required this.primary,
    required this.primaryContrast,
    required this.background,
    required this.backgroundInverted,
    required this.border,
    required this.borderInverted,
    required this.shadow,
    required this.shadowInverted,
    required this.text,
    required this.textInverted,
    required this.danger,
    required this.dangerContrast,
  });
}

const appLightColors = AppThemeColors(
  themeMode: AppAvailableThemeMode.light,
  // Main
  primary: AppColors.primary,
  primaryContrast: AppColors.primaryContrast,
  // Foundation
  background: AppColors.background,
  backgroundInverted: AppColors.backgroundInverted,
  border: AppColors.border,
  borderInverted: AppColors.borderInverted,
  shadow: AppColors.shadow,
  shadowInverted: AppColors.shadowInverted,
  // Typography
  text: AppColors.text,
  textInverted: AppColors.textInverted,
  // Semantic
  danger: AppColors.dangerLight,
  dangerContrast: AppColors.dangerContrast,
);

const appDarkColors = AppThemeColors(
  themeMode: AppAvailableThemeMode.dark,
  // Main
  primary: AppColors.primary,
  primaryContrast: AppColors.primaryContrast,
  // Foundation
  background: AppColors.backgroundInverted,
  backgroundInverted: AppColors.background,
  border: AppColors.borderInverted,
  borderInverted: AppColors.border,
  shadow: AppColors.shadowInverted,
  shadowInverted: AppColors.shadow,
  // Typography
  text: AppColors.textInverted,
  textInverted: AppColors.text,
  // Semantic
  danger: AppColors.dangerDark,
  dangerContrast: AppColors.dangerContrast,
);
