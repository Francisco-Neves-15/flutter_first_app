import "package:flutter/foundation.dart" show ChangeNotifier;

/// Minimal in-memory session state — just enough to drive the navigation
/// demo (splash → login/home, logout → login). There's no real backend and
/// no persistence: closing the app always resets this back to logged out.
/// See `lib/navigation/README_NAVIGATION.md`.
class AuthController extends ChangeNotifier {
  AuthController._();

  static final instance = AuthController._();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
