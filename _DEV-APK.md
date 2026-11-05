# Android Build (APK/AAB)

How to generate an installable Android build from this project, what each
build mode means, where the app's identity (name/id/version) lives, and how
release signing (keystore) works.

---

## 1. Build modes

| Mode | Command | What it is |
|---|---|---|
| Debug | `flutter run` or `flutter build apk --debug` | JIT-compiled, debug banner, asserts on, bigger/slower. Works standalone once installed (doesn't need to stay connected to the dev machine) — you only lose hot reload/DevTools when disconnected. |
| Profile | `flutter build apk --profile` | Same performance characteristics as release, keeps some profiling hooks. Mostly used to measure real performance, rarely for distribution. |
| Release | `flutter build apk --release` | AOT-compiled (native code), no debug banner, asserts off, tree-shaking applied. This is the "real" build to hand to someone or publish. |

`flutter run` defaults to **debug**. To install the release build on a plugged-in device via `flutter run`, you need `flutter run --release` explicitly.

### Where the output lands

```
build/app/outputs/flutter-apk/app-debug.apk
build/app/outputs/flutter-apk/app-profile.apk
build/app/outputs/flutter-apk/app-release.apk
```

### APK vs AAB

`flutter build apk` produces a universal (or split-per-ABI, see below) `.apk` — good for sideloading/sharing directly. Play Store today expects an **AAB** instead:
```terminal
flutter build appbundle --release
```
output: `build/app/outputs/bundle/release/app-release.aab`. You don't need this for sideloading/testing, only when actually publishing to the Play Store.

### Optional: smaller APKs split per architecture

```terminal
flutter build apk --release --split-per-abi
```
Generates one APK per CPU architecture (`app-armeabi-v7a-release.apk`, `app-arm64-v8a-release.apk`, `app-x86_64-release.apk`) instead of one fat universal APK. Good for manual distribution when you know the target device's architecture (almost always `arm64-v8a` on modern phones); skip this if you just want one APK that works everywhere.

---

## 2. App identity — name, package id, version

| What | File | Key |
|---|---|---|
| App display name (Android) | [`android/app/src/main/AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml) | `android:label="..."` |
| App display name (iOS) | `ios/Runner/Info.plist` | `CFBundleDisplayName` (and `CFBundleName`, shorter/no-spaces variant) |
| Package id / Application ID | [`android/app/build.gradle.kts`](android/app/build.gradle.kts) | `defaultConfig { applicationId = "..." }` |
| Version name + code | [`pubspec.yaml`](pubspec.yaml) | `version: 1.0.0+1` → `1.0.0` is `versionName`, `1` (after `+`) is `versionCode` — both flow automatically into Android/iOS via `flutter.versionName`/`flutter.versionCode` in `build.gradle.kts`, no manual sync needed. |

**Important:** `applicationId` is the app's unique identity on a device/Play Store (like a package name in other ecosystems) — it still needs to be unique and matches the template default (`com.example.flutter_first_app`) until changed. `android:label`/`CFBundleDisplayName` are only the human-readable name shown under the icon — changing one does **not** change the other. Both exist independently.

> Web (`web/manifest.json` → `name`/`short_name`, `web/index.html` → `<title>`) and Desktop (Windows `windows/runner/Runner.rc` / `CMakeLists.txt` `BINARY_NAME`, similarly for Linux/macOS) have their own separate "app name" spots too — only relevant if you ever build for those targets.

---

## 3. Release signing (keystore)

Right now `android/app/build.gradle.kts` signs the `release` build type with the **debug keystore**:
```kotlin
buildTypes {
    release {
        // TODO: Add your own signing config for the release build.
        signingConfig = signingConfigs.getByName("debug")
    }
}
```
This is fine to build, install on your own device, and share informally for testing. It is **not** fine for the Play Store — Google requires every release to be signed with the same, privately-held key for the app's whole lifetime (lose it, and you can never update that app listing again).

### Generating your own keystore

```terminal
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
- Keep the resulting `.jks` file **outside the repo**, and keep its password somewhere safe (a password manager) — it's not recoverable if lost.
- `keytool` ships with the JDK; if it's not found, it's usually under `<jdk-install>/bin/keytool` (Android Studio bundles its own JDK too).

### Wiring it into the project

1. Create `android/key.properties` (this file must **never** be committed — add it to `.gitignore`):
   ```properties
   storePassword=<keystore password>
   keyPassword=<key password>
   keyAlias=upload
   storeFile=<absolute or relative path to the .jks file>
   ```
2. In `android/app/build.gradle.kts`, load that file and point `release` at it instead of the debug config:
   ```kotlin
   import java.util.Properties
   import java.io.FileInputStream

   val keystorePropertiesFile = rootProject.file("key.properties")
   val keystoreProperties = Properties()
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(FileInputStream(keystorePropertiesFile))
   }

   android {
       signingConfigs {
           create("release") {
               keyAlias = keystoreProperties["keyAlias"] as String?
               keyPassword = keystoreProperties["keyPassword"] as String?
               storeFile = keystoreProperties["storeFile"]?.let { file(it) }
               storePassword = keystoreProperties["storePassword"] as String?
           }
       }
       buildTypes {
           release {
               signingConfig = signingConfigs.getByName("release")
           }
       }
   }
   ```
3. Rebuild with `flutter build apk --release` — it now comes out signed with your own key instead of the debug one.

### What to check when copying this project into a new app

- A new app needs its **own** keystore — never reuse a keystore/alias across unrelated apps, and definitely never reuse the one used for a previously published app unless you explicitly intend to.
- Don't forget to actually add `android/key.properties` (and any `*.jks` you keep inside the project, though keeping it outside is safer) to `.gitignore`.

---

## 4. Quick checklist before generating a release build to hand off/publish

- [ ] `applicationId` changed from the template default, and unique for this app.
- [ ] `android:label` (and iOS `CFBundleDisplayName`) set to the real app name.
- [ ] App icon + splash generated for the final branding (see [`_DEV-PACKAGES.md`](_DEV-PACKAGES.md)).
- [ ] `version:` in `pubspec.yaml` bumped as needed.
- [ ] Release signed with your own keystore (not the debug one) if this build is going further than your own test devices.
