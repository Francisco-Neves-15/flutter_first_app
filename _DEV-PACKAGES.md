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

## Icons / Splash Screen (`flutter_launcher_icons`, `flutter_native_splash`) — planned, not installed yet

**Status:** not installed yet — add a proper section here once they're added to `pubspec.yaml` and configured (this is just a placeholder so the step isn't skipped).

Expected flow once added (to confirm against the actual config used):

- `flutter_launcher_icons`: configure the source icon + platforms in `pubspec.yaml` (or a separate `flutter_launcher_icons.yaml`), then run:
  ```terminal
  dart run flutter_launcher_icons
  ```
- `flutter_native_splash`: configure colors/image in `pubspec.yaml` (or `flutter_native_splash.yaml`), then run:
  ```terminal
  dart run flutter_native_splash:create
  ```

Both of these are **one-shot generators**: they write native platform files (Android `mipmap-*`/`drawable`, iOS `AppIcon.appiconset`, etc.) once, and you re-run the command whenever the source icon/splash image changes — they don't run automatically on `flutter pub get`/`run`/`build` like `gen-l10n` does.
