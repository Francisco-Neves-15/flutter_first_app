import "package:flutter/material.dart";

/// The SideMenu's own navigation policy (see
/// `lib/navigation/README_NAVIGATION.md`):
/// - Tapping the item for the route already showing just closes the menu.
/// - Tapping one that's already an ancestor on the stack (e.g.
///   "Configurações" while inside "Privacidade") pops back to it instead
///   of stacking a duplicate.
/// - Otherwise, pushes it normally.
void navigateOrPopToRoute(
  BuildContext context, {
  required String routeName,
  required WidgetBuilder builder,
}) {
  final navigator = Navigator.of(context);
  final scaffold = Scaffold.of(context);

  // A Scaffold's "drawer is open" flag isn't reset just because its route
  // became invisible (pushed under a new screen, or paused while popped
  // through) — without closing it here, it would still be open the next
  // time this screen becomes visible again. `Navigator.pop` is what
  // actually closes it (same as the Drawer's own "X" button); guarded by
  // `isDrawerOpen`/`isEndDrawerOpen` so it doesn't accidentally pop the
  // underlying route when no drawer is open.
  void closeMenu() {
    if (scaffold.isDrawerOpen || scaffold.isEndDrawerOpen) {
      Navigator.pop(context);
    }
  }

  if (ModalRoute.of(context)?.settings.name == routeName) {
    // closeMenu(); // already there — just close the Drawer
    return;
  }

  closeMenu();

  var found = false;
  navigator.popUntil((route) {
    if (route.settings.name == routeName) {
      found = true;
      return true;
    }
    return route.isFirst;
  });

  if (!found) {
    navigator.push(
      MaterialPageRoute(settings: RouteSettings(name: routeName), builder: builder),
    );
  }
}

/// Whether `routeName` is the current route, or (when `includeSubRoutes` is
/// `true`, the default) an ancestor of it — e.g. "/settings" while the
/// current route is "/settings/privacy" — used to keep a parent item
/// highlighted while inside one of its sub-routes. Pass `includeSubRoutes:
/// false` for items that should only highlight on an exact route match.
bool isRouteSelected(
  BuildContext context,
  String routeName, {
  bool includeSubRoutes = true,
}) {
  final currentRouteName = ModalRoute.of(context)?.settings.name;
  if (currentRouteName == null) return false;
  if (currentRouteName == routeName) return true;
  if (!includeSubRoutes) return false;
  return currentRouteName.startsWith("$routeName/");
}
