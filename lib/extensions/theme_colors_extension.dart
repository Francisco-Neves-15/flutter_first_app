import 'package:flutter/material.dart';
import 'package:flutter_first_app/styles/app_colors_theme.dart' show AppThemeColors, appLightColors, appDarkColors;

extension ThemeColorsExtension on BuildContext {
  AppThemeColors get colors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? appDarkColors
        : appLightColors;
  }
}

// using in widgets

// e.g.:

// import "package:flutter_first_app/theme/theme_colors_extension.dart";
// class AppScaffold extends StatelessWidget {
//   ...
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.colors.background
//       ...
//     );
//   }
// }
