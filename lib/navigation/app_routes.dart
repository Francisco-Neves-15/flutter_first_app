/// Route names used as `RouteSettings.name`. This is the one place that
/// owns these strings — `AppSideMenu`'s pop-to-existing-or-push logic
/// (`Navigator.popUntil`) searches the stack by comparing against these,
/// so every screen reachable from the side menu needs to push itself with
/// a matching name. See `lib/navigation/README_NAVIGATION.md`.
class AppRoutes {
  static const login = "/login";
  static const home = "/home";
  static const settings = "/settings";
  static const settingsPrivacy = "/settings/privacy";
}
