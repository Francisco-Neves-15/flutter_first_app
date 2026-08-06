# Theme

Same pattern as [`lib/localization/README_LOCALIZATION.md`](../localization/README_LOCALIZATION.md): extension + controller + config, each with a fixed responsibility.

## 1. Where everything lives

| File | Responsibility |
|---|---|
| [`lib/theme/app_colors.dart`](app_colors.dart) | **All** raw colors for the app, without any theme rules. It is just the palette (`primary`, `background`, `danger`, ...), with no knowledge of what is "light" or "dark". |
| [`lib/theme/app_colors_theme.dart`](app_colors_theme.dart) | Applies the rules: takes raw colors from `app_colors.dart` and builds the two sets (`appLightColors`, `appDarkColors`), typed as `AppThemeColors`. This is where it is decided, for example, that in dark mode `primary` becomes the old `primaryInverted`. |
| [`lib/styles/app_theme.dart`](../styles/app_theme.dart) | `AppTheme.build(colors)` — turns an `AppThemeColors` instance into a complete Material `ThemeData` (see section 3). |
| [`lib/config/app_config_themes.dart`](../config/app_config_themes.dart) | Source of truth for theme **information**: enums (`AppAvailableThemeMode`, `AppAvailableThemeBrightness`) and UI identifiers (`AppThemeLabels`, `AppThemeIcons`). Contains no colors — only metadata about what exists. |
| [`lib/controllers/theme_controller.dart`](../controllers/theme_controller.dart) | Session state: which `AppAvailableThemeMode` is currently active (see section 4). |
| [`lib/extensions/theme_extension.dart`](../extensions/theme_extension.dart) | `context.appTheme` — quick access to resolved colors/styles for the current brightness (see section 5). |

> `AppThemeLabels` currently has text in English (`"Light"`, `"Dark"`, `"Autodetect"`...) solely to identify each option during development. In the final version, if these labels are displayed to the end-user, they should originate from `l10n` (see the localization README) — turning `AppThemeLabels` into an internal identifier rather than display text.

## 2. `app_colors.dart` → `app_colors_theme.dart`

`app_colors.dart` is a flat palette (`static const Color`), without context. `app_colors_theme.dart` is what determines **what each color means** within a theme: it constructs `AppThemeColors` (an immutable class containing `primary`, `background`, `text`, etc. + the `themeMode` it belongs to) twice — once for light (`appLightColors`), once for dark (`appDarkColors`) — remapping/inverting palette entries as necessary. To create a new theme (e.g., a third brightness or a brand variant), mapping rules belong here, never in `app_colors.dart`.

## 3. Why `AppTheme.build(colors)`

```dart
theme: AppTheme.build(appLightColors),
darkTheme: AppTheme.build(appDarkColors),
themeMode: ThemeController.instance.themeMode,
```

Material's `ThemeData` is an immutable object — it needs to be **constructed all at once in full**; individual properties cannot be mutated after `MaterialApp` has been mounted. However, Material's default `ThemeData` is unaware of our palette (`AppThemeColors`); it maintains its own concept of `ColorScheme`, button styles, etc.

`AppTheme.build(AppThemeColors colors)` exists to solve this: it receives our custom color tokens (`appLightColors`/`appDarkColors`) **before** Material constructs `ThemeData`, and uses them to build `ColorScheme` as well as all component `*ThemeData` (`elevatedButtonTheme`, `appBarTheme`, `navigationBarTheme`, ...) manually. In other words: instead of letting Material pick default colors and attempting to override them afterwards, we deliver a fully pre-built `ThemeData` with the correct colors embedded — Material simply applies what was created.

This is why there are two calls (`theme:` and `darkTheme:`) — each builds an independent, complete `ThemeData`, one per brightness. Which of the two is active at any given moment is determined by `themeMode:` (`ThemeMode.light` / `.dark` / `.system`), read from `ThemeController`.

## 4. `theme_controller.dart` — current responsibility

Holds **which mode is active in the session** (`AppAvailableThemeMode`: `auto`/`light`/`dark`) and exposes:
- `mode` / `themeMode` — reads the state (`themeMode` already converted to the `ThemeMode` expected by `MaterialApp`).
- `resolvedBrightness(context)` — when mode is set to `auto`, resolves which brightness is actually being applied (`Theme.of(context).brightness`), since "auto" itself is not a brightness.
- `setTheme(value)` — updates the mode and notifies listeners (`ChangeNotifier`).
- `isAuto` / `isLight` / `isDark`, `labelThemeMode`, `labelResolvedTheme`, `labelDisplay` — helper methods for reading/displaying state.

Like `LangController`, it does not persist across sessions — remaining strictly in-memory for now.

## 5. `context.appTheme` (`theme_extension.dart`)

```dart
Text("Body", style: context.appTheme.textStyles.body),
Text("Direct token color", style: TextStyle(color: context.appTheme.colors.primary)),
```

Resolves, via `BuildContext`, which `AppThemeColors` corresponds to the active brightness (`isDark ? appDarkColors : appLightColors`) and re-exposes text styles (`AppTextStyles.appTextStyle`). It follows the same architecture as `context.l10n`: the extension remains isolated in `lib/extensions/`, simply resolving/grouping data that already exists elsewhere (`app_colors_theme.dart` + `app_text_styles.dart`) — it is not a new source of data.
