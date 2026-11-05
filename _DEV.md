# Running

Execute this before starting the project, after "clone" or "pull" the repository.

## Install existing dependencies

```terminal
flutter pub get
```

or

```terminal
dart pub get
```

## Developer Mode (Windows)
### ms-settings:developers

**Windows only:** adding a package that ships native/platform code (plugins, not pure-Dart packages) may fail with `Building with plugins requires symlink support` / asking to enable Developer Mode. Fix once per machine:
```terminal
start ms-settings:developers
```
then toggle "Developer Mode" on in the Settings window that opens.

This is only necessary if the warning interferes with startup, package installation, or publishing; Enabling this option is not strictly required; for **security** reasons, only turn it on when necessary.

## Run with a "device" included in the line

```terminal
flutter run -d *method*
```

**e.g.**:
```terminal
flutter run -d emulator-5554
```

#### You can simply use this if you don't know the name; the options will be visible in the terminal.

```terminal
flutter run
```

## Get the Devices (method)

```terminal
flutter devices
```

**e.g.**:

**Name** • **Method** • **Extra Info**

```terminal
sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64    • Android 16 (API 36) (emulator)
Windows (desktop)            • windows       • windows-x64    • Microsoft Windows [versÆo 10.0.19045.6466]
Chrome (web)                 • chrome        • web-javascript • Google Chrome 149.0.7827.103
Edge (web)                   • edge          • web-javascript • Microsoft Edge 149.0.4022.62
```

---

# Clean/Clear/Cache

```terminal
flutter clean
```

```terminal
flutter pub get
```

# Generators

> ⚠️ Some packages in this project need a manual command/step to work (generators, codegen, etc.) — they don't just work after `flutter pub get`. 

> See **[_DEV-PACKAGES.md](_DEV-PACKAGES.md)** for the list and the exact flow for each one (currently: l10n).

---

# Build (Android APK/AAB)

> See **[_DEV-APK.md](_DEV-APK.md)** for build modes (debug/profile/release), where app name/id/version live, and release signing (keystore).

---

# Scripts/Commands

## Flutter Linter

```terminal
flutter analyze
```

## Dart Analyzer

```terminal
dart analyze
```

# Running with Flags

```terminal
flutter run -d *method* --dart-define=ENV_FLAG_NAME=value
```

**e.g.**:

```terminal
flutter run --dart-define=DEBUG_FRONT=true --dart-define=DEBUG_BACK=true --dart-define=DEBUG_IN_DEV=true
```

> More in `lib\config\app_config_debug.dart`

# New App

## Versions

```terminal
flutter --version
```

```terminal
dart --version
```

## New Project

```terminal
flutter create app_name
```

### Rules to app name:

- ✖ `app-name`
- ✖ `app.name`
- ✖ `AppName`
- ✖ `Appname`
- ✖ `appName`
---
- ✔ `appname`
- ✔ `app_name`

## Get in directory

```dart
cd app_name
```

and Run
