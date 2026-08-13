import 'package:flutter/material.dart' show Locale;

enum AppAvailableLocale { en, pt }

extension AppAvailableLocaleMapping on AppAvailableLocale {
  /// `Locale` instance to feed `MaterialApp.locale` / `supportedLocales`.
  Locale get locale {
    switch (this) {
      case AppAvailableLocale.en:
        return const Locale("en");
      case AppAvailableLocale.pt:
        return const Locale("pt");
    }
  }
}

/// List of every locale this app ships translations for.
/// Keep in sync with `lib/localization/strings/app_<code>.arb` and `l10n.yaml`.
const List<AppAvailableLocale> kAppAvailableLocales = AppAvailableLocale.values;

class AppLocaleLabels {
  static const String en = "English";
  static const String pt = "Português";

  static String of(AppAvailableLocale value) {
    switch (value) {
      case AppAvailableLocale.en:
        return en;
      case AppAvailableLocale.pt:
        return pt;
    }
  }
}

class AppLocaleAcronym {
  static const String en = "US";
  static const String pt = "BR";

  static String of(AppAvailableLocale value) {
    switch (value) {
      case AppAvailableLocale.en:
        return en;
      case AppAvailableLocale.pt:
        return pt;
    }
  }
}

class AppLocaleFlags {
  static const String en = "assets/localization/flags-ISO3166-4x3-svgs/us.svg";
  static const String pt = "assets/localization/flags-ISO3166-4x3-svgs/br.svg";

  static String of(AppAvailableLocale value) {
    switch (value) {
      case AppAvailableLocale.en:
        return en;
      case AppAvailableLocale.pt:
        return pt;
    }
  }
}
