import "package:flutter/material.dart";
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show MenuPosition;
import "package:flutter_first_app/widgets/layout/headers/app_header.dart" show AppHeader;
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
  final bool useAppBar;
  final String? appBarTitle;
  final bool appBarUseMenu;
  final MenuPosition appBarMenuPosition;
  final List<Widget>? appBarActions;

  /// AppHeader
  final bool useAppHeader;
  final String? appHeaderTitle;
  final bool appHeaderUseMenu;
  final MenuPosition appHeaderMenuPosition;
  final List<Widget>? appHeaderActions;

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
    this.useAppBar = false,
    this.appBarTitle,
    this.appBarUseMenu = true,
    this.appBarMenuPosition = MenuPosition.end,
    this.appBarActions,
    // AppHeader
    this.useAppHeader = false,
    this.appHeaderTitle,
    this.appHeaderUseMenu = true,
    this.appHeaderMenuPosition = MenuPosition.end,
    this.appHeaderActions,
  });

  @override
  Widget build(BuildContext context) {

    Widget resolvedAppHeader = AppHeader(
      title: appHeaderTitle,
      useMenu: appHeaderUseMenu,
      menuPosition: appHeaderMenuPosition,
      actions: appHeaderActions,
    );

    List<Widget> childList = [
      if (useAppHeader) ...[resolvedAppHeader],
      body
    ];

    Widget childColumn = Column(
      mainAxisAlignment: .start,
      crossAxisAlignment: .start,
      children: childList,
    );

    Widget resolvedChild;
    if (safeArea && scroll) {
      resolvedChild = SafeArea(child: ListView(children: childList));
    } else if (safeArea) {
      resolvedChild = SafeArea(child: childColumn);
    } else if (scroll) {
      resolvedChild = ListView(children: childList);
    } else {
      resolvedChild = childColumn;
    }

    return Scaffold(
      appBar: useAppBar ? AppNavigationHeader(
        title: appBarTitle,
        actions: appBarActions,
        menu: appBarUseMenu,
        menuPosition: appBarMenuPosition,
      ) : null,
      body: resolvedChild,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SafeArea(bottom: true, child: Container(height: 64, color: Color(0x50FF0000))),
    );
  }
}
