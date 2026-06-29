import "package:flutter/material.dart";
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show MenuPosition;
import "package:flutter_first_app/widgets/layout/headers/app_navigation_header.dart" show AppNavigationHeader;

class AppScaffold extends StatelessWidget {

  final Widget body;
  // SafeArea
  final bool safeArea;
  final bool scroll;
  // AppBar
  final Color? appBarBackgroundColor;
  final Color? appBarSurfaceTintColor;
  // Default Scaffold
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// AppBar
  final String title;
  final bool useAppBar;
  final bool menu;
  final MenuPosition menuPosition;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    required this.body,
    // SafeArea
    this.safeArea = true,
    this.scroll = true,
    // AppBar
    this.appBarBackgroundColor,
    this.appBarSurfaceTintColor,
    // Default Scaffold
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    // AppBar
    this.title = "",
    this.useAppBar = true,
    this.menu = true,
    this.menuPosition = MenuPosition.end,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {

    Widget resolvedChild;
    if (safeArea && scroll) {
      resolvedChild = SafeArea(child: ListView(children: [body]));
    } else if (safeArea) {
      resolvedChild = SafeArea(child: body);
    } else if (scroll) {
      resolvedChild = ListView(children: [body]);
    } else {
      resolvedChild = body;
    }

    return Scaffold(
      appBar: useAppBar ? AppNavigationHeader(
        title: title,
        actions: actions,
        menu: menu,
        menuPosition: menuPosition,
      ) : null,
      body: resolvedChild,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
