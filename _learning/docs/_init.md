# Init

### Versions

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

## Running

Execute this before starting the project, after "clone" or "pull" the repository.

```terminal
flutter pub get
```
or
```terminal
dart pub get
```

```terminal
flutter run -d *method*
```

**e.g.**:
```terminal
flutter run -d emulator-5554
```

## Get the Devices (method)

```terminal
flutter devices
```

**e.g.**:
| Name | Method | 
| ---- | ------ |

```terminal
sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64    • Android 16 (API 36) (emulator)
Windows (desktop)            • windows       • windows-x64    • Microsoft Windows [versÆo 10.0.19045.6466]
Chrome (web)                 • chrome        • web-javascript • Google Chrome 149.0.7827.103
Edge (web)                   • edge          • web-javascript • Microsoft Edge 149.0.4022.62
```

---

### Flutter Linter

```terminal
flutter analyze
```

### Dart Analyzer

```terminal
dart analyze
```
