import "package:flutter/material.dart";
import "package:flutter_first_app/config/app_config_locales.dart" show AppAvailableLocale, AppAvailableLocaleMapping, AppLocaleLabels, AppLocaleAcronym, AppLocaleFlags;

class LangController extends ChangeNotifier {
  LangController._();

  static final instance = LangController._();

  AppAvailableLocale _current = AppAvailableLocale.en;

  /// User Language Choice
  AppAvailableLocale get current => _current;

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

  /// Default method for defining the language
  void setLocale(AppAvailableLocale value) {
    _current = value;
    notifyListeners();
  }
}

// using in:
// e.g.:

// import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;
// import "package:flutter_first_app/config/app_available_locales.dart" show AppAvailableLocale;
// LangController.instance.setLocale(AppAvailableLocale.pt);

// Persistence (SharedPreferences) and OS auto-detect are intentionally left
// out for now — same "later" as ThemeController's persistence.
