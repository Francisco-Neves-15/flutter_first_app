# Dev Packages — manual steps/actions needed

Some packages used in this project don't "just work" after `flutter pub get` —
they need a generator command, a specific file edited, or some other manual
step to actually reflect in the app. This file documents each one so it isn't
forgotten when copying this project (or parts of it) into a new app.

> Add a new section here every time a package needs something beyond
> `flutter pub get` + import.

---

## l10n / Localization (`flutter_localizations` + `intl` + `gen-l10n`)

**Status:** already set up and working automatically on this project.

### Where things live

- Source of truth for string content → `.arb` files in `lib/localization/strings/` (`app_en.arb`, `app_pt.arb`, ...).
- Generated code (**never edit by hand**) → `lib/localization/generated/` (`app_localizations.dart` + one per locale).
- App-side ergonomic wrapper → [`lib/localization/l10n.dart`](lib/localization/l10n.dart) (the `L10n` class, with `common`, `pageHome`, `pageSettings`, etc.).
- Full explanation of the whole flow → [`lib/localization/README_LOCALIZATION.md`](lib/localization/README_LOCALIZATION.md).

### The flow, summarized

1. Add/edit a string key in **all** `.arb` files under `lib/localization/strings/` (same key in every language file).
2. Generate the Dart code for it:
   ```terminal
   flutter gen-l10n
   ```
   This step is **not strictly manual** — because `pubspec.yaml` has `flutter: generate: true`, Flutter also runs `gen-l10n` automatically on `flutter pub get`, `flutter run` and `flutter build`. Running it manually is only needed if you want the generated files to update *without* running/building the app (e.g. right after editing an `.arb`, to get autocomplete/no-red-squiggles in the IDE).
3. Expose the new key in [`lib/localization/l10n.dart`](lib/localization/l10n.dart): add a getter in the matching namespace class (or create a new namespace class if it's a new screen/area), pointing to the flat generated getter (e.g. `_t.pageHomeNewKey`).
4. Use it in a screen via `context.l10n` (e.g. `context.l10n.pageHome.newKey`).

### What to check when copying this project into a new app

- `pubspec.yaml` needs `flutter_localizations` (sdk), `intl` (pinned to the version your Flutter SDK expects), and `flutter: generate: true`.
- `l10n.yaml` must exist at the project root (defines `arb-dir`, `template-arb-file`, `output-dir`, etc.) — without it `gen-l10n` has nothing to read.
- `main.dart` needs `localizationsDelegates: AppLocalizations.localizationsDelegates`, `supportedLocales`, and a `locale` — otherwise the generated class exists but nothing wires it into the app.

---

## App Icon (`flutter_launcher_icons`)

**Status:** installed and already generated (dev dependency, `0.14.4`).

### Where things live

- Config lives inside `pubspec.yaml`, under the `flutter_launcher_icons:` key (not a separate file). Example:
  ```yaml
  flutter_launcher_icons:
    android: true
    ios: true
    image_path: "assets/icon/app_icon.png"

    # Android Adaptive Icon
    adaptive_icon_background: "#RRGGBB"
    adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"

    # Remove icon transparency on iOS
    remove_alpha_ios: true
  ```
- `remove_alpha_ios: true` — iOS doesn't allow a transparent icon, so alpha is stripped on export.
- Generated output (**never edit by hand**, gets overwritten every run):
  - Android → `android/app/src/main/res/mipmap-*/ic_launcher.png` + `mipmap-anydpi-v26/ic_launcher.xml` (adaptive icon) + `drawable-*/ic_launcher_foreground.png`.
  - iOS → `ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png`.

### The flow

1. Replace the source icon image(s) pointed at by `image_path` (and/or `adaptive_icon_foreground`) with the new icon.
2. Run:
   ```terminal
   dart run flutter_launcher_icons
   ```
3. Nothing else to wire manually — `AndroidManifest.xml` (`android:icon="@mipmap/ic_launcher"`) and iOS already point at the generated files by default.

This is a **one-shot generator** — it does not run automatically on `flutter pub get`/`run`/`build`. Re-run the command by hand whenever the source icon image changes.

---

## Splash Screen (`flutter_native_splash`)

**Status:** installed and already generated (dev dependency, `2.4.8`).

### Where things live

- Config lives inside `pubspec.yaml`, under the `flutter_native_splash:` key. Example:
  ```yaml
  flutter_native_splash:
    color: "#RRGGBB"
    image: assets/splash/splash_image.png

    android: true
    ios: true

    # Android 12+ has its own native splash API with icon-in-a-circle
    # constraints, so it often needs a dedicated, simpler image.
    android_12:
      color: "#RRGGBB"
      image: assets/splash/splash_image_android12.png
  ```
- Generated output (**never edit by hand**):
  - Android → `drawable*/splash.png`, `drawable*/android12splash.png`, `drawable-v21/launch_background.xml` + `drawable/launch_background.xml`.
  - iOS → `ios/Runner/Assets.xcassets/LaunchBackground.imageset`, `ios/Runner/Base.lproj/LaunchScreen.storyboard`.

### The flow

1. Replace the source image(s)/colors pointed at by `image` (and/or `android_12.image`) in `pubspec.yaml`.
2. Run:
   ```terminal
   dart run flutter_native_splash:create
   ```
3. If you ever want to remove the native splash (e.g. switching to a fully custom one), there's also `dart run flutter_native_splash:remove`.

Also a **one-shot generator** — doesn't run automatically, re-run by hand whenever the splash image/color changes.

### What to check when copying this project into a new app

- Both generators read their config straight from `pubspec.yaml` — copy the `flutter_launcher_icons:` / `flutter_native_splash:` blocks along with the dev dependencies.
- Swap `image_path` / `image` / `adaptive_icon_foreground` to the new app's own assets before running the commands — otherwise it'll regenerate the old app's icon/splash into the new app.
- Run both commands once after `flutter pub get`, before the first `flutter build` — unlike l10n, nothing regenerates these automatically.
