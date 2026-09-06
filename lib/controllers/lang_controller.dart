import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_first_app/config/app_config_locales.dart" show AppAvailableLocale, AppAvailableLocaleMapping, AppLocaleLabels, AppLocaleAcronym, AppLocaleFlags;

// Cloud Sync Detection Area - Line: 68
// If the app ever gains user accounts, this is where a per-account lookup
// would run before falling back to the value persisted on this device.

class LangController extends ChangeNotifier {
  LangController._();

  static final instance = LangController._();

  static const _prefsKey = "app_locale";

  /// Default locale used while there's no real OS-locale auto-detection yet
  /// (that part is intentionally left for later — see localization README).
  static const _fallbackLocale = AppAvailableLocale.en;

  AppAvailableLocale _current = _fallbackLocale;

  /// `true` while following "auto" (device/default) instead of a locale the
  /// user picked by hand.
  bool _isAutoMode = true;

  /// `false` while still on the auto-detected default nobody has touched
  /// yet; `true` once the user has picked an option themselves (including
  /// explicitly picking "Auto-detect").
  bool _hasUserChosen = false;

  /// Whether `loadPersistedPreference()` has already run.
  bool _isLoaded = false;

  /// User Language Choice
  AppAvailableLocale get current => _current;

  bool get isAutoMode => _isAutoMode;

  bool get hasUserChosen => _hasUserChosen;

  bool get isLoaded => _isLoaded;

  /// Locale used by MaterialApp.
  Locale get locale => _current.locale;

  // Bool's use

  bool isCurrent(AppAvailableLocale value) => _current == value;

  // In Controller Interface

  /// Label for the language currently selected
  String get labelCurrent => AppLocaleLabels.of(_current);

  /// Acronym for the language currently selected
  String get acronymCurrent => AppLocaleAcronym.of(_current);

  /// Flags for the language currently selected
  String get flagsCurrent => AppLocaleFlags.of(_current);

  // Methods

  /// Reads the preference persisted on this device. Call once, awaited,
  /// before `runApp` (see `main.dart`) — that way the first frame already
  /// renders with the right language instead of flashing the default and
  /// then switching once this finishes.
  Future<void> loadPersistedPreference() async {
    // user_locale = FetchUserPreference("locale");

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);

    if (raw == null) {
      // First run ever on this device: nothing saved yet. Apply the
      // default (auto) and persist the "unchosen" marker, so a later load
      // can tell "never touched" apart from "explicitly chose Auto-detect".
      _isAutoMode = true;
      _current = _detectDefault();
      _hasUserChosen = false;
      await prefs.setString(_prefsKey, _encode(auto: true, chosen: false, locale: _current));
    } else {
      final decoded = _decode(raw);
      _isAutoMode = decoded.$1;
      _hasUserChosen = decoded.$2;
      _current = _isAutoMode ? _detectDefault() : decoded.$3;
    }

    _isLoaded = true;
    notifyListeners();
  }

  /// Default method for defining the language
  void setLocale(AppAvailableLocale value) {
    _isAutoMode = false;
    _current = value;
    _hasUserChosen = true;
    notifyListeners();
    _persist();
  }

  /// Switches back to "auto" (device/default) instead of a fixed language.
  void setAutoDetect() {
    _isAutoMode = true;
    _current = _detectDefault();
    _hasUserChosen = true;
    notifyListeners();
    _persist();
  }

  /// Stand-in for real OS-locale detection (left for later — see
  /// `lib/localization/README.md`). For now "auto" just resolves to a
  /// fixed default, same as any other locale that was never chosen.
  static AppAvailableLocale _detectDefault() => _fallbackLocale;

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      _encode(auto: _isAutoMode, chosen: _hasUserChosen, locale: _current),
    );
  }

  static String _encode({required bool auto, required bool chosen, required AppAvailableLocale locale}) {
    if (auto) return chosen ? "auto" : "auto-unchosen";
    return switch (locale) {
      AppAvailableLocale.en => "en",
      AppAvailableLocale.pt => "pt",
    };
  }

  /// Returns `(isAutoMode, hasUserChosen, locale)`. `locale` is only
  /// meaningful when `isAutoMode` is `false`.
  static (bool, bool, AppAvailableLocale) _decode(String raw) {
    return switch (raw) {
      "auto-unchosen" => (true, false, _fallbackLocale),
      "auto" => (true, true, _fallbackLocale),
      "en" => (false, true, AppAvailableLocale.en),
      "pt" => (false, true, AppAvailableLocale.pt),
      _ => (true, false, _fallbackLocale),
    };
  }

}

// using in:
// e.g.:

// import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;
// import "package:flutter_first_app/config/app_config_locales.dart" show AppAvailableLocale;
// LangController.instance.setLocale(AppAvailableLocale.pt);
