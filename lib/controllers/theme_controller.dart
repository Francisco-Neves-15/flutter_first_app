import 'package:flutter/material.dart';
import 'package:flutter_first_app/theme/app_available_themes.dart' show AppAvailableThemeMode, AppAvailableThemeBrightness;

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final instance = ThemeController._();

  AppAvailableThemeMode _mode = AppAvailableThemeMode.auto;

  /// User Theme Choice
  AppAvailableThemeMode get mode => _mode;

  /// ThemeMode used by MaterialApp.
  ThemeMode get themeMode {
    switch (_mode) {
      case AppAvailableThemeMode.light:
        return ThemeMode.light;

      case AppAvailableThemeMode.dark:
        return ThemeMode.dark;

      case AppAvailableThemeMode.auto:
        return ThemeMode.system;

    }
  }

  /// Theme effectively applied
  AppAvailableThemeBrightness resolvedTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return brightness == Brightness.dark
        ? AppAvailableThemeBrightness.dark
        : AppAvailableThemeBrightness.light;
  }

  // In Controller Interface

  /// Label for AppAvailableThemeMode
  String get labelThemeMode {
    switch (_mode) {
      case AppAvailableThemeMode.auto:
        return "Autodetect";
      case AppAvailableThemeMode.light:
        return "Light";
      case AppAvailableThemeMode.dark:
        return "Dark";
    }
  }

  /// Label for AppAvailableThemeBrightness
  /// Context is required because the resolved theme belongs to `BuildContext`, not `ThemeMode`
  String labelResolvedTheme(BuildContext context) {
    switch (resolvedTheme(context)) {
      case AppAvailableThemeBrightness.light:
        return "Light";
      case AppAvailableThemeBrightness.dark:
        return "Dark";
    }
  }

  /// Label for AppAvailableThemeMode + AppAvailableThemeBrightness
  /// Context is required because, if it is "auto": The resolved theme belongs to the BuildContext, not the ThemeMode.
  String labelDisplay(BuildContext context) {
    if (_mode == AppAvailableThemeMode.auto) {
      return "$labelThemeMode (${labelResolvedTheme(context)})";
    }
    return labelThemeMode;
  }

  // Methods

  /// Default method for defining the theme
  void setTheme(AppAvailableThemeMode value) {
    _mode = value;
    notifyListeners();
  }

}
