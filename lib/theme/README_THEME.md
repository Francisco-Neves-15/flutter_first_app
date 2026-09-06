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

Holds **which mode is active** (`AppAvailableThemeMode`: `auto`/`light`/`dark`) and persists that choice on the device. It exposes:
- `mode` / `themeMode` — reads the state (`themeMode` already converted to the `ThemeMode` expected by `MaterialApp`).
- `hasUserChosen` — `false` only for the very first run, before the user has touched the theme setting at all (see section 4.1); `true` in every other case, including "auto" explicitly picked.
- `resolvedBrightness(context)` — when mode is set to `auto`, resolves which brightness is actually being applied (`Theme.of(context).brightness`), since "auto" itself is not a brightness.
- `loadPersistedPreference()` — reads the stored preference (see section 4.1). `await` it once, before `runApp` (see `main.dart`), so the first frame already renders in the right theme.
- `setTheme(value)` — updates the mode, marks it as user-chosen, notifies listeners (`ChangeNotifier`), and persists it.
- `isAuto` / `isLight` / `isDark`, `labelThemeMode`, `labelResolvedTheme`, `labelDisplay` — helper methods for reading/displaying state.

**"Auto" detection**: unlike locale (see the localization README), theme detection needs no code of ours — `AppAvailableThemeMode.auto` maps to `ThemeMode.system`, and Flutter itself watches the OS's light/dark setting and rebuilds automatically (via `MediaQuery`/`PlatformDispatcher.platformBrightness`) whenever it changes. `resolvedBrightness(context)` is just reading that already-resolved result back out.

### 4.1 Persistence format

`ThemeController` stores one `SharedPreferences` string key (`app_theme_mode`), one of:

| Stored value | Meaning |
|---|---|
| *(key absent — `null`)* | Never loaded before on this device (fresh install). Only ever seen once, inside `loadPersistedPreference()`. |
| `"auto-unchosen"` | Following "auto" (system brightness), and the user has never touched the theme setting. This is what gets written the very first time `loadPersistedPreference()` runs. |
| `"auto"` | Following "auto", but the user explicitly picked "Auto-detect" at some point. Behaves identically to `"auto-unchosen"` today — the distinction only matters if you later want to force a "pick your theme" onboarding step for users who never chose anything. |
| `"light"` / `"dark"` | A mode the user picked by hand. |

`_encode`/`_decode` in `theme_controller.dart` are the only place that translates between this string format and `(AppAvailableThemeMode, hasUserChosen)`. `_encode` switches over the `AppAvailableThemeMode` enum with no `default` case, so the Dart compiler forces a case for every enum member — adding a mode without updating `_encode` won't compile. `_decode` switches over the raw *string* read from storage instead, so it has no such compiler safety net (storage can contain garbage from an older app version) — it keeps a manual `_` fallback case, and adding a mode means remembering to add its string case there by hand too.

### 4.2 Adding a new theme mode/variant — checklist

Two different things can be meant by "a new theme", with very different amounts of work:

**A new color variant of an existing mode** (e.g. an AMOLED-black dark mode) — no new `AppAvailableThemeMode` needed:
1. Add the raw colors to `app_colors.dart` (still no theme rules there).
2. Add the mapping/remapping rules in `app_colors_theme.dart` (a new `AppThemeColors` constant, e.g. `appAmoledColors`).
3. Pass it into `AppTheme.build(...)` wherever `main.dart` currently only passes `appLightColors`/`appDarkColors` — this needs its own selection mechanism (e.g. extending `AppAvailableThemeMode`, see below), since `MaterialApp.theme`/`darkTheme` only accepts one `ThemeData` each for light/dark.

**An actual new mode value** (a true 4th option beyond auto/light/dark) — this is more involved, because Flutter's own `ThemeMode` enum only has 3 members (`system`/`light`/`dark`); `MaterialApp` has no 4th slot to plug a new `ThemeData` into automatically. Adding one means:
1. Add the value to `AppAvailableThemeMode` in `app_config_themes.dart`, plus its `AppThemeLabels`/`AppThemeIcons` entries — the compiler will point at `ThemeController.themeMode`'s switch and `_encode` (both exhaustive) until they're updated.
2. Add the `"<value>"` string case to `_decode` (not compiler-enforced, see 4.1).
3. Decide how it actually renders — since `MaterialApp` itself can't route a 4th mode, you'd need extra plumbing beyond what `themeMode:` gives you for free (e.g. wrapping the app to force `theme:`/`darkTheme:` to the same custom `ThemeData` regardless of the resolved `ThemeMode`).

## 5. `context.appTheme` (`theme_extension.dart`)

```dart
Text("Body", style: context.appTheme.textStyles.body),
Text("Direct token color", style: TextStyle(color: context.appTheme.colors.primary)),
```

Resolves, via `BuildContext`, which `AppThemeColors` corresponds to the active brightness (`isDark ? appDarkColors : appLightColors`) and re-exposes text styles (`AppTextStyles.appTextStyle`). It follows the same architecture as `context.l10n`: the extension remains isolated in `lib/extensions/`, simply resolving/grouping data that already exists elsewhere (`app_colors_theme.dart` + `app_text_styles.dart`) — it is not a new source of data.
