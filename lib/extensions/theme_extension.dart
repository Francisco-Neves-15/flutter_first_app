import 'package:flutter/material.dart';
import 'package:flutter_first_app/styles/app_colors_theme.dart' show AppThemeColors, appLightColors, appDarkColors;
import 'package:flutter_first_app/styles/app_text_styles.dart' show AppTextStyles, AppTextStyle;

// >>>>> OLD: context.colors

// extension ThemeColorsExtension on BuildContext {
//   AppThemeColors get colors {
//     final brightness = Theme.of(this).brightness;
//     return brightness == Brightness.dark
//         ? appDarkColors
//         : appLightColors;
//   }
// }

// >>>>> OLD: context.theme (using a extension for AppTheme)

// extension BuildContextThemeExtension on BuildContext {
//   ThemeData get theme => Theme.of(this);
// }

// extension ThemeDataExtension on ThemeData {
//   // context.theme.isDark
//   bool get isDark => brightness == Brightness.dark;
//   // context.theme.isLight
//   bool get isLight => brightness == Brightness.light;
//   // context.theme.colors
//   AppThemeColors get colors => isDark ? appDarkColors : appLightColors;
// }

// >>>>> OLD: context.appTheme.

class AppThemeContext {
  const AppThemeContext._(this._theme);

  final ThemeData _theme;

  // context.appTheme.isDark
  bool get isDark => _theme.brightness == Brightness.dark;

  // context.appTheme.isLight
  bool get isLight => !isDark;

  // context.appTheme.colors
  AppThemeColors get colors => isDark ? appDarkColors : appLightColors;

  // context.appTheme.textStyles
  AppTextStyle get textStyles => AppTextStyles.appTextStyle;

}

extension AppThemeExtensionContext on BuildContext {
  AppThemeContext get appTheme => AppThemeContext._(Theme.of(this));
}

// using in:
// e.g.:

// import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
// context.appTheme.isDark
