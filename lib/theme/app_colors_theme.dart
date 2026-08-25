import "package:flutter/material.dart" show Color, immutable;
import "package:flutter_first_app/theme/app_colors.dart" show AppColors;
import "package:flutter_first_app/config/app_config_themes.dart" show AppAvailableThemeMode;

@immutable
class AppThemeColors {
  final AppAvailableThemeMode themeMode;

  final Color primary;
  final Color primaryContrast;
  final Color primaryAlpha;
  final Color primaryInverted;
  final Color primaryInvertedContrast;
  final Color primaryInvertedAlpha;
  final Color background;
  final Color backgroundInverted;
  final Color backgroundSecondary;
  final Color backgroundSecondaryInverted;
  final Color border;
  final Color borderInverted;
  final Color shadow;
  final Color shadowInverted;
  final Color hover;
  final Color hoverInverted;
  final Color text;
  final Color textInverted;
  final Color textSecondary;
  final Color textSecondaryInverted;
  final Color neutral;
  final Color neutralContrast;
  final Color danger;
  final Color dangerContrast;
  final Color base;
  final Color baseInverted;
  final Color light;
  final Color dark;

  const AppThemeColors({
    required this.themeMode,
    required this.primary,
    required this.primaryContrast,
    required this.primaryAlpha,
    required this.primaryInverted,
    required this.primaryInvertedContrast,
    required this.primaryInvertedAlpha,
    required this.background,
    required this.backgroundInverted,
    required this.backgroundSecondary,
    required this.backgroundSecondaryInverted,
    required this.border,
    required this.borderInverted,
    required this.shadow,
    required this.shadowInverted,
    required this.hover,
    required this.hoverInverted,
    required this.text,
    required this.textInverted,
    required this.textSecondary,
    required this.textSecondaryInverted,
    required this.neutral,
    required this.neutralContrast,
    required this.danger,
    required this.dangerContrast,
    required this.base,
    required this.baseInverted,
    required this.light,
    required this.dark,
  });
}

const appLightColors = AppThemeColors(
  themeMode: AppAvailableThemeMode.light,
  // Main
  primary: AppColors.primary,
  primaryContrast: AppColors.primaryContrast,
  primaryAlpha: AppColors.primaryAlpha,
  primaryInverted: AppColors.primaryInverted,
  primaryInvertedContrast: AppColors.primaryInvertedContrast,
  primaryInvertedAlpha: AppColors.primaryInvertedAlpha,
  // Foundation
  background: AppColors.background,
  backgroundInverted: AppColors.backgroundInverted,
  backgroundSecondary: AppColors.backgroundSecondary,
  backgroundSecondaryInverted: AppColors.backgroundSecondaryInverted,
  border: AppColors.border,
  borderInverted: AppColors.borderInverted,
  shadow: AppColors.shadow,
  shadowInverted: AppColors.shadowInverted,
  hover: AppColors.hover,
  hoverInverted: AppColors.hoverInverted,
  // Typography
  text: AppColors.text,
  textInverted: AppColors.textInverted,
  textSecondary: AppColors.textSecondary,
  textSecondaryInverted: AppColors.textSecondaryInverted,
  // Semantic
  neutral: AppColors.neutral,
  neutralContrast: AppColors.neutralContrast,
  danger: AppColors.dangerLight,
  dangerContrast: AppColors.dangerContrast,
  // Base
  base: AppColors.base,
  baseInverted: AppColors.baseInverted,
  light: AppColors.light,
  dark: AppColors.dark,
);

const appDarkColors = AppThemeColors(
  themeMode: AppAvailableThemeMode.dark,
  // Main
  primary: AppColors.primaryInverted,
  primaryContrast: AppColors.primaryInvertedContrast,
  primaryAlpha: AppColors.primaryInvertedAlpha,
  primaryInverted: AppColors.primary,
  primaryInvertedContrast: AppColors.primaryContrast,
  primaryInvertedAlpha: AppColors.primaryAlpha,
  // Foundation
  background: AppColors.backgroundInverted,
  backgroundInverted: AppColors.background,
  backgroundSecondary: AppColors.backgroundSecondaryInverted,
  backgroundSecondaryInverted: AppColors.backgroundSecondary,
  border: AppColors.borderInverted,
  borderInverted: AppColors.border,
  shadow: AppColors.shadowInverted,
  shadowInverted: AppColors.shadow,
  hover: AppColors.hoverInverted,
  hoverInverted: AppColors.hover,
  // Typography
  text: AppColors.textInverted,
  textInverted: AppColors.text,
  textSecondary: AppColors.textSecondaryInverted,
  textSecondaryInverted: AppColors.textSecondary,
  // Semantic
  neutral: AppColors.neutral,
  neutralContrast: AppColors.neutralContrast,
  danger: AppColors.dangerDark,
  dangerContrast: AppColors.dangerContrast,
  // Base
  base: AppColors.baseInverted,
  baseInverted: AppColors.base,
  light: AppColors.light,
  dark: AppColors.dark,
);
