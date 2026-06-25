import 'package:flutter/material.dart';
import 'package:flutter_first_app/theme/app_available_themes.dart' show AppAvailableThemes;

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final instance = ThemeController._();

  AppAvailableThemes mode = AppAvailableThemes.auto;

  ThemeMode get themeMode {
    switch (mode) {
      case AppAvailableThemes.light:
        return ThemeMode.light;
      case AppAvailableThemes.dark:
        return ThemeMode.dark;
      case AppAvailableThemes.auto:
        return ThemeMode.system;
    }
  }

  void setTheme(AppAvailableThemes value) {
    mode = value;
    notifyListeners();
  }
}
