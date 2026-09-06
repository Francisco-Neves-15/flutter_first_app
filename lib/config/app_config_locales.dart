import 'package:flutter/material.dart' show IconData, Locale;
import 'package:material_symbols_icons/symbols.dart' show Symbols;

// enum AppAvailableLocale { en, pt, fr }
enum AppAvailableLocale { en, pt }

const IconData appLocaleIcon = Symbols.translate_rounded;

extension AppAvailableLocaleMapping on AppAvailableLocale {
  /// `Locale` instance to feed `MaterialApp.locale` / `supportedLocales`.
  Locale get locale {
    switch (this) {
      case AppAvailableLocale.en:
        return const Locale("en");
      case AppAvailableLocale.pt:
        return const Locale("pt");
      // case AppAvailableLocale.fr:
      //   return const Locale("fr");
    }
  }
}

/// List of every locale this app ships translations for.
/// Keep in sync with `lib/localization/strings/app_<code>.arb` and `l10n.yaml`.
const List<AppAvailableLocale> kAppAvailableLocales = AppAvailableLocale.values;

class AppLocaleLabels {
  static const String en = "English";
  static const String pt = "Português";
  // static const String fr = "Français";

  static String of(AppAvailableLocale value) {
    switch (value) {
      case AppAvailableLocale.en:
        return en;
      case AppAvailableLocale.pt:
        return pt;
      // case AppAvailableLocale.fr:
      //   return fr;
    }
  }
}

class AppLocaleAcronym {
  static const String en = "US";
  static const String pt = "BR";
  // static const String fr = "FR";

  static String of(AppAvailableLocale value) {
    switch (value) {
      case AppAvailableLocale.en:
        return en;
      case AppAvailableLocale.pt:
        return pt;
      // case AppAvailableLocale.fr:
      //   return fr;
    }
  }
}

class AppLocaleFlags {
  static const String en = "assets/localization/flags-ISO3166-4x3-svgs/us.svg";
  static const String pt = "assets/localization/flags-ISO3166-4x3-svgs/br.svg";
  // static const String fr = "assets/localization/flags-ISO3166-4x3-svgs/fr.svg";

  static String of(AppAvailableLocale value) {
    switch (value) {
      case AppAvailableLocale.en:
        return en;
      case AppAvailableLocale.pt:
        return pt;
      // case AppAvailableLocale.fr:
      //   return fr;
    }
  }
}
