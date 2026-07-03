import 'package:flutter/material.dart' show IconData;
import 'package:material_symbols_icons/symbols.dart' show Symbols;

enum AppAvailableThemeMode { auto, light, dark }
enum AppAvailableThemeBrightness { light, dark }

class AppThemeIcons {
  static const IconData light = Symbols.light_mode_rounded;
  static const IconData dark = Symbols.dark_mode_rounded;
  static const IconData autoLight = Symbols.routine_rounded;
  static const IconData autoDark = Symbols.routine_rounded;
  static const IconData undetected = Symbols.question_mark_rounded;
}
