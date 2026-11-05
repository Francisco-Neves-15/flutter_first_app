import "package:flutter/foundation.dart";
import "package:package_info_plus/package_info_plus.dart" show PackageInfo;

/// Reads the app's real version/build number straight from the platform
/// (the same `version:` compiled into the app from `pubspec.yaml` at build
/// time) instead of keeping a second, manually-typed copy in the codebase.
class AppVersionController extends ChangeNotifier {
  AppVersionController._();

  static final instance = AppVersionController._();

  PackageInfo? _info;

  /// Whether `load()` has already run.
  bool get isLoaded => _info != null;

  /// e.g. "0.1.0" — matches `version:`'s left side in `pubspec.yaml`.
  String get versionName => _info?.version ?? "not-found";

  /// e.g. "1" — matches `version:`'s right side (after the `+`) in `pubspec.yaml`.
  String get buildNumber => _info?.buildNumber ?? "not-found";

  /// e.g. "0.1.0+1" — `versionName` and `buildNumber` combined, same format
  /// used in `pubspec.yaml`.
  String get full => buildNumber.isEmpty ? versionName : "$versionName+$buildNumber";

  /// Reads the version/build number from the platform. Call once, awaited,
  /// before it's first displayed (see `SplashScreen`'s `_bootstrap`).
  Future<void> load() async {
    _info = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}
