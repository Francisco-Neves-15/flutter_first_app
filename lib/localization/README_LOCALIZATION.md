# Localization l10n (or i18n)

How this project uses Flutter's official `gen-l10n`, from the `.arb` file to the `context.l10n` used in screens.

## 1. What a project needs to use localization

In `pubspec.yaml`:

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: 0.20.2 # version pinned by flutter_localizations for your Flutter version

flutter:
  generate: true
```

- `flutter_localizations` brings ready-to-use translations from Flutter itself (Material/Cupertino widget texts, like the "Cancel" in date pickers).
- `intl` is the package that interprets plural/placeholder/date/number rules at runtime.
- `generate: true` enables the code generator (`gen-l10n`). Without this, nothing below runs automatically.

In the root of the project, `l10n.yaml` configures the generator:

```yaml
arb-dir: lib/localization/strings
template-arb-file: app_en.arb
output-dir: lib/localization/generated
output-localization-file: app_localizations.dart
output-class: AppLocalizations
nullable-getter: false
```

- `arb-dir`: folder containing `.arb` files, one per language.
- `template-arb-file`: which `.arb` serves as the **template** — the source of truth for the list of keys, placeholder types, plurals, and descriptions. Every translation `.arb` must contain the exact same keys as the template.
- `output-dir` / `output-localization-file` / `output-class`: where and under what name the generator writes the resulting Dart code.
- `nullable-getter: false`: makes `AppLocalizations.of(context)` return a non-null value (prevents having to constantly use `!`).

### Auto-generation

`generate: true` makes Flutter run `gen-l10n` automatically during `flutter pub get`, `flutter run`, and `flutter build`. You can also force it manually:

```bash
flutter gen-l10n
```

The output is written to `lib/localization/generated/` (`app_localizations.dart`, `app_localizations_en.dart`, `app_localizations_pt.dart`). **These 3 files are build artifacts — never edit them manually**, as they are rewritten from scratch on every generation. The sole source of truth for string content remains the `.arb` files in `lib/localization/strings/`.

`app_localizations.dart` defines an abstract class `AppLocalizations` with a getter/method per `.arb` key (e.g., `String get commonOk;`). `app_localizations_en.dart`/`_pt.dart` implement this class, each returning literal strings for that language. `AppLocalizations.localizationsDelegates` (used in `main.dart`) also originates there — it is Flutter's standard mechanism for loading translations, not user-managed content.

## 2. Project standard: where the source of truth lives

- **String content** → `.arb` files in `lib/localization/strings/` (never anywhere else).
- **Available languages & UI identification** (label, icon/flag) → [`lib/config/app_config_locales.dart`](../config/app_config_locales.dart). This is the source of truth for language *information* — not for strings. It must be manually kept in sync with existing `.arb` files (if you add an `AppAvailableLocale` without a matching `.arb`, the generated delegate will reject that locale).

## 3. Usage in `main.dart`

```dart
// Theme
theme: AppTheme.build(appLightColors),
darkTheme: AppTheme.build(appDarkColors),
themeMode: ThemeController.instance.themeMode,

// Localization
locale: LangController.instance.locale,
supportedLocales: AppAvailableLocale.values.map((value) => value.locale),
localizationsDelegates: AppLocalizations.localizationsDelegates,
```

- `locale` and `supportedLocales` are product decisions — they come from our `LangController` (session state) and `AppAvailableLocale` (config), not from generated code.
- `localizationsDelegates` is a framework mechanism (loads `AppLocalizations` + built-in Material/Cupertino/Widgets translations) — which is why it comes ready from `generated`.

Inside a screen:

```dart
@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  ...
}
```

`context.l10n` is the extension in [`lib/extensions/localization_extension.dart`](../extensions/localization_extension.dart) — it is simply `BuildContext` resolving `L10n` from `i18n.dart` (see section 5). Separating `context.l10n` from `i18n.dart` follows the same pattern as `context.appTheme` for themes: the extension lives in `lib/extensions/`, while logic/data reside in the domain file.

## 4. How to add a new string

1. Add the key to the **template** first — `app_en.arb`. It defines the contract (key name, placeholder types, plural rules). You can include a `@key` block with metadata (see section 6).
2. Add the exact same key, translated, to `app_pt.arb` (and any other existing `.arb`). If a key exists in the template but is missing from a translation, the generator throws an error.
3. Run `flutter gen-l10n` (or `flutter pub get`, or simply `flutter run`/`flutter build` again) to regenerate `lib/localization/generated/`.
4. If the key belongs to a group (`common*`, `pageHome*`, ...), add the corresponding getter in `i18n.dart` pointing to it (a manual step — the generator knows nothing about groups).

## 5. `i18n.dart` — why group strings

The generated `AppLocalizations` class is **flat**: one getter per key with no hierarchy. `lib/localization/i18n.dart` exists to reorganize these keys into logical groups (`CommonStrings`, `PageHomeStrings`, `PageSettingsStrings`...), allowing `l10n.common.confirm` / `l10n.pageHome.welcome` instead of `l10n.commonConfirm` / `l10n.pageHomeWelcome`. This is purely a Dart convention built on top of the generated class — there is no additional data source; it is the exact same `AppLocalizations` regrouped. The naming convention in `.arb` files (`common*`, `pageHome*`) is what makes this grouping cohesive.

The `L10n` class centralizes this and exposes:
- `l10n.raw` → direct access to the generated `AppLocalizations`, for standalone keys not yet part of a group.
- `l10n.common`, `l10n.pageHome`, `l10n.pageSettings`, ... → groups.

`context.l10n` (in `lib/extensions/localization_extension.dart`) simply resolves `L10n.of(context)`, identical to how `context.appTheme` resolves the active theme.

## 6. `lang_controller.dart` — current responsibility

Currently, `LangController` only holds **which language is active in the session** (an `AppAvailableLocale`) and exposes:
- `current` / `locale` — reads the current state.
- `setLocale(value)` — updates the language and notifies listeners (`ChangeNotifier`, same as `ThemeController`).
- `labelCurrent` — label of the current language (via `AppLocaleLabels`).

What it does NOT do: persistence across sessions (SharedPreferences) or automatic system language detection. It remains purely in-memory and resets upon restarting the app — same as `ThemeController` today.

---

## Examples of `@` metadata in `.arb`

The `@key` block (prefixed with `@` before the key name) is where you add **description** (documentation for translators, not visible at runtime) and **placeholders** (variables accepted by the string). Each placeholder's type/format and ICU rules (`plural`, `select`) live inside the key value itself.

### Simple placeholder (interpolation)

```json
"welcomeWithName": "Welcome {firstName} {lastName}!",
"@welcomeWithName": {
  "description": "Greets the user by first and last name.",
  "placeholders": {
    "firstName": { "type": "String" },
    "lastName": { "type": "String" }
  }
}
```

Usage: `l10n.raw.welcomeWithName("Ana", "Silva")` → `"Welcome Ana Silva!"`.

### Plural (ICU `plural`)

```json
"newMessages": "{count, plural, =0{No new messages} =1{One new message} other{{count} new messages}}",
"@newMessages": {
  "description": "Number of unread messages in the inbox.",
  "placeholders": {
    "count": { "type": "int" }
  }
}
```

Usage: `l10n.raw.newMessages(0)`, `l10n.raw.newMessages(1)`, `l10n.raw.newMessages(5)` — `intl` automatically selects the correct variant (`=0`, `=1`, `other`) based on the integer value.

### String conditional (ICU `select`) — e.g., pronoun/gender

Similar to `plural`, but compares **strings** instead of numbers. Useful for pronouns, titles, forms of address, etc.

```json
"userGreeting": "{gender, select, male{Welcome back, sir} female{Welcome back, madam} other{Welcome back}}",
"@userGreeting": {
  "description": "Greeting adapted to the user's stated gender/pronoun.",
  "placeholders": {
    "gender": { "type": "String" }
  }
}
```

Usage: `l10n.raw.userGreeting("male")` → `"Welcome back, sir"`; any value other than `male`/`female` falls back to `other`.

> The last two examples (`newMessages` is already in actual `.arb` files; `userGreeting`/`select` is illustrative for this README and has not yet been added to the `.arb` files).
