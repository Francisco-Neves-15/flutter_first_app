import "package:flutter/foundation.dart" show kDebugMode;
import "package:flutter/material.dart";
import "package:flutter_first_app/docs/widgets/layout/bad_usages.dart" show BadUsagesLayoutWidgets;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisPositionHorizontal;
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show AppBarType, MenuButtonPosition, MenuButtonLocation, resolveActions, resolveLeading;
import "package:flutter_first_app/widgets/layout/headers/app_header.dart" show AppHeader;
import "package:flutter_first_app/widgets/layout/headers/app_navigation_bar.dart" show AppNavigationBar;
import "package:flutter_first_app/widgets/ui/app_logo.dart" show AppLogo, getAppLogoSize;

class AppScaffold extends StatelessWidget {

  final Widget body;

  // SafeArea
  final bool? safeArea;

  // Default Scaffold
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  // AppBar
  final AppBarType? appBar;
  final String? appBarTitle;
  final List<Widget>? appBarLeading;
  final List<Widget>? appBarActions;
  final bool? appBarLogo;

  // MenuButton
  final bool? menuButton;
  final MenuButtonLocation? menuButtonLocation;
  final MenuButtonPosition? menuButtonPosition;

  // Side Menu
  final bool? sideMenu;
  final AppAxisPositionHorizontal? sideMenuOrigin;

  // BottomNavigationBar
  final Widget? bottomNavigationBar;

  const AppScaffold({
    super.key,
    required this.body,
    // SafeArea
    this.safeArea = true,
    // Default Scaffold
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    // AppBar
    this.appBar,
    this.appBarTitle,
    this.appBarLeading,
    this.appBarActions,
    this.appBarLogo,
    // MenuButton
    this.menuButton = true,
    this.menuButtonLocation = .actions,
    this.menuButtonPosition = .end,
    // Side Menu
    this.sideMenu = true,
    this.sideMenuOrigin = .left,
    // BottomNavigationBar
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {

    void showBadUsages(int entry) {
      switch (entry) {
        case 1:
          debugPrint(BadUsagesLayoutWidgets.e001.warn());
          break;
        default:
          break;
      }
    }

    // Initial Warn's

    if (kDebugMode && menuButton == true && sideMenu != true) showBadUsages(1);

    // Essentials

    Widget? widgetMenuButton = menuButton! ? Builder(
      builder: (scaffoldContext) => IconButton(
        onPressed: () {
          if (kDebugMode && menuButton == true && sideMenu != true) {
            showBadUsages(1);
          } else {
            sideMenuOrigin == AppAxisPositionHorizontal.right
                ? Scaffold.of(scaffoldContext).openEndDrawer()
                : Scaffold.of(scaffoldContext).openDrawer();
          }
        },
        icon: const Icon(Icons.menu_rounded),
        iconSize: 24,
        color: context.appTheme.colors.text,
      ),
    ) : null;

    // Resolves

    final resolvedActions = resolveActions(
      menuButton: menuButtonLocation == .actions ? widgetMenuButton : null,
      menuButtonPosition: menuButtonPosition,
      actions: appBarActions,
    );

    final resolvedLeading = resolveLeading(
      menuButton: menuButtonLocation == .leading ? widgetMenuButton : null,
      menuButtonPosition: menuButtonPosition,
      logo: appBarLogo == true ? AppLogo(height: getAppLogoSize(appBar), width: getAppLogoSize(appBar)) : null,
    );

    // Header
    Widget resolvedAppHeader = AppHeader(
      title: appBarTitle,
      leading: resolvedLeading,
      actions: resolvedActions
    );

    // Drawer
    Widget drawerContent = Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home'),
            selected: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );

    // Content

    Widget content = Column(
      children: [
        if (appBar != null && appBar == AppBarType.header) resolvedAppHeader,
        Expanded(child: body),
      ],
    );

    if (safeArea != null) {
      content = SafeArea(child: content);
    }

    // Continue
    return Scaffold(
      appBar: (appBar != null && appBar == AppBarType.navigation) ? AppNavigationBar(
        title: appBarTitle,
        leading: resolvedLeading,
        actions: resolvedActions,
        appBar: appBar,
      ) : null,
      body: content,
      // Extras
      resizeToAvoidBottomInset: true,
      // Floating Button
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      // Drawer
      drawer: sideMenuOrigin == AppAxisPositionHorizontal.left ? drawerContent : null,
      endDrawer: sideMenuOrigin == AppAxisPositionHorizontal.right ? drawerContent : null,
      // Bottom Navigation Bar
      bottomNavigationBar: bottomNavigationBar != null 
          ? SafeArea(bottom: true, child: bottomNavigationBar!) 
          : null,
    );

  }
}
