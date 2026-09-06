import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_first_app/config/app_config_themes.dart" show AppAvailableThemeMode, AppAvailableThemeBrightness;

// Cloud Sync Detection Area - Line: 126
// If the app ever gains user accounts, this is where a per-account lookup
// would run before falling back to the value persisted on this device.

class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final instance = ThemeController._();

  static const _prefsKey = "app_theme_mode";

  AppAvailableThemeMode _mode = AppAvailableThemeMode.auto;

  /// `false` while the app is still on the auto-detected default nobody
  /// has touched yet; `true` once the user has picked an option themselves
  /// (including explicitly picking "Auto-detect").
  bool _hasUserChosen = false;

  /// Whether `loadPersistedPreference()` has already run.
  bool _isLoaded = false;

  /// User Theme Choice
  AppAvailableThemeMode get mode => _mode;

  bool get hasUserChosen => _hasUserChosen;

  bool get isLoaded => _isLoaded;

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

  /// Theme actually applied (Brightness)
  AppAvailableThemeBrightness resolvedBrightness(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return brightness == Brightness.dark
        ? AppAvailableThemeBrightness.dark
        : AppAvailableThemeBrightness.light;
  }

  // Bool's use

  /// Is Auto the Theme applied |
  /// Context is required because the resolved theme belongs to `BuildContext`, not `ThemeMode`
  bool isAuto(BuildContext context) {
    return _mode == AppAvailableThemeMode.auto;
  }

  /// Is Light the Theme applied |
  /// Context is required because the resolved theme belongs to `BuildContext`, not `ThemeMode`
  bool isLight(BuildContext context) {
    // ===== Using: Theme actually applied
    // final brightness = Theme.of(context).brightness;
    // return brightness == Brightness.light;
    // ===== Using: Theme applied by user
    return _mode == AppAvailableThemeMode.light;
  }

  /// Is Dark the Theme applied |
  /// Context is required because the resolved theme belongs to `BuildContext`, not `ThemeMode`
  bool isDark(BuildContext context) {
    // ===== Using: Theme actually applied
    // final brightness = Theme.of(context).brightness;
    // return brightness == Brightness.dark;
    // ===== Using: Theme applied by user
    return _mode == AppAvailableThemeMode.dark;
  }

  // In Controller Interface

  /// Label for AppAvailableThemeMode
  String get labelThemeMode {
    switch (_mode) {
      case AppAvailableThemeMode.auto:
        return "auto";
      case AppAvailableThemeMode.light:
        return "light";
      case AppAvailableThemeMode.dark:
        return "dark";
    }
  }

  /// Label for AppAvailableThemeBrightness
  /// Context is required because the resolved theme belongs to `BuildContext`, not `ThemeMode`
  String labelResolvedTheme(BuildContext context) {
    switch (resolvedBrightness(context)) {
      case AppAvailableThemeBrightness.light:
        return "light";
      case AppAvailableThemeBrightness.dark:
        return "dark";
    }
  }

  /// Label for AppAvailableThemeMode + AppAvailableThemeBrightness
  /// Context is required because, if it is "auto": The resolved theme belongs to the BuildContext, not the ThemeMode.
  String labelDisplay(BuildContext context) {
    if (_mode == AppAvailableThemeMode.auto) {
      return "$labelThemeMode-${labelResolvedTheme(context)}";
    }
    return labelThemeMode;
  }

  // Methods

  /// Reads the preference persisted on this device. Call once, awaited,
  /// before `runApp` (see `main.dart`) — that way the first frame already
  /// renders with the right theme instead of flashing the default and then
  /// switching once this finishes.
  Future<void> loadPersistedPreference() async {
    // user_theme = FetchUserPreference("theme");

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);

    if (raw == null) {
      // First run ever on this device: nothing saved yet. Apply the
      // default (auto) and persist the "unchosen" marker, so a later load
      // can tell "never touched" apart from "explicitly chose Auto-detect".
      _mode = AppAvailableThemeMode.auto;
      _hasUserChosen = false;
      await prefs.setString(_prefsKey, _encode(_mode, chosen: false));
    } else {
      final decoded = _decode(raw);
      _mode = decoded.$1;
      _hasUserChosen = decoded.$2;
    }

    _isLoaded = true;
    notifyListeners();
  }

  /// Default method for defining the theme
  void setTheme(AppAvailableThemeMode value) {
    _mode = value;
    _hasUserChosen = true;
    notifyListeners();
    _persist();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _encode(_mode, chosen: _hasUserChosen));
  }

  static String _encode(AppAvailableThemeMode mode, {required bool chosen}) {
    if (mode == AppAvailableThemeMode.auto && !chosen) return "auto-unchosen";
    return switch (mode) {
      AppAvailableThemeMode.auto => "auto",
      AppAvailableThemeMode.light => "light",
      AppAvailableThemeMode.dark => "dark",
    };
  }

  /// Returns `(mode, hasUserChosen)`.
  static (AppAvailableThemeMode, bool) _decode(String raw) {
    return switch (raw) {
      "auto-unchosen" => (AppAvailableThemeMode.auto, false),
      "auto" => (AppAvailableThemeMode.auto, true),
      "light" => (AppAvailableThemeMode.light, true),
      "dark" => (AppAvailableThemeMode.dark, true),
      _ => (AppAvailableThemeMode.auto, false),
    };
  }

}

// using in:
// e.g.:

// import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
// import "package:flutter_first_app/styles/app_colors_all.dart" show AppColors;
// backgroundColor: appBarBackgroundColor ?? (ThemeController.instance.isDark(context) ? AppColors.backgroundInverted : AppColors.background),
