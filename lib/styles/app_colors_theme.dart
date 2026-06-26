import "package:flutter/material.dart" show Color;
import "package:flutter_first_app/styles/app_colors_all.dart" show AppColors;
import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode;

class AppThemeColors {
  final AppAvailableThemeMode themeMode;

  final Color background;
  final Color backgroundInverted;
  final Color border;
  final Color borderInverted;
  final Color text;
  final Color textInverted;
  final Color danger;

  const AppThemeColors({
    required this.themeMode,
    required this.background,
    required this.backgroundInverted,
    required this.border,
    required this.borderInverted,
    required this.text,
    required this.textInverted,
    required this.danger,
  });
}

const appLightColors = AppThemeColors(
  themeMode: AppAvailableThemeMode.light,
  // Main
  // no changes
  // Foundation
  background: AppColors.background,
  backgroundInverted: AppColors.backgroundInverted,
  border: AppColors.border,
  borderInverted: AppColors.borderInverted,
  // Typography
  text: AppColors.text,
  textInverted: AppColors.textInverted,
  // Semantic
  danger: AppColors.dangerLight,
);

const appDarkColors = AppThemeColors(
  themeMode: AppAvailableThemeMode.dark,
  // Main
  // no changes
  // Foundation
  background: AppColors.backgroundInverted,
  backgroundInverted: AppColors.background,
  border: AppColors.borderInverted,
  borderInverted: AppColors.border,
  // Typography
  text: AppColors.textInverted,
  textInverted: AppColors.text,
  // Semantic
  danger: AppColors.dangerDark,
);
