import "dart:io" show Platform;
import "package:flutter/material.dart";
import "package:flutter/foundation.dart" show kDebugMode;
import "package:flutter_first_app/docs/widgets/layout/bad_usages.dart" show BadUsagesLayoutWidgets;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisPositionHorizontal;
import "package:flutter_first_app/navigation/utils.dart" show shouldShowBackButton;
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show 
  AppBarType,
  MenuButtonPosition,
  MenuButtonLocation,
  resolveActions,
  resolveLeading
;
import "package:flutter_first_app/widgets/layout/headers/app_header.dart" show AppHeader;
import "package:flutter_first_app/widgets/layout/headers/app_navigation_bar.dart" show AppNavigationBar;
import "package:flutter_first_app/widgets/layout/sidemenu/app_side_menu.dart" show AppSideMenu, SideMenuAnchor;
import "package:flutter_first_app/widgets/ui/app_logo.dart" show AppLogo, getAppLogoSize;
import "package:material_symbols_icons/symbols.dart" show Symbols;

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

  // Back
  final bool? backAutomatic;
  final bool? backButton;
  final VoidCallback? backFunction;

  // MenuButton
  final bool? menuButton;
  final MenuButtonLocation? menuButtonLocation;
  final MenuButtonPosition? menuButtonPosition;

  // Side Menu
  final bool? sideMenu;
  final AppAxisPositionHorizontal? sideMenuOrigin;
  final String? sideMenuTitle;
  final SideMenuAnchor? sideMenuAnchor;

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
    // Back
    this.backAutomatic = true,
    this.backButton,
    this.backFunction,
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
    this.sideMenuOrigin = .right,
    this.sideMenuTitle,
    this.sideMenuAnchor = .origin,
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

    // `AppNavigationBar` reserves exactly `getAppLogoSize(appBar)` px per
    // leading item (see `_leadingWidth`). A plain `IconButton` ignores that
    // and keeps Material's default 48x48 minimum tap target regardless of
    // `iconSize` — `constraints` alone doesn't fix it either, since
    // `MaterialTapTargetSize.padded` (the `ThemeData` default) pads the
    // button's actual footprint back up to 48 even when `constraints` says
    // smaller. `shrinkWrap` is what turns that padding off, so the button's
    // real occupied space finally matches what the width calculation
    // assumes.
    final double leadingIconButtonSize = getAppLogoSize(appBar);
    final BoxConstraints leadingIconButtonConstraints = BoxConstraints.tightFor(
      width: leadingIconButtonSize,
      height: leadingIconButtonSize,
    );
    const MaterialTapTargetSize leadingIconButtonTapTargetSize = MaterialTapTargetSize.shrinkWrap;

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
        padding: EdgeInsets.zero,
        constraints: leadingIconButtonConstraints,
        // materialTapTargetSize: leadingIconButtonTapTargetSize,
      ),
    ) : null;

    IconData widgetBackButtonIcon = (Platform.isMacOS || Platform.isIOS)
        ? Symbols.arrow_back_ios_new_rounded
        : Symbols.arrow_back_rounded;

    Widget? widgetBackButton = shouldShowBackButton(
      context,
      backAutomatic: backAutomatic,
      backButton: backButton,
    ) ? IconButton(
      onPressed: backFunction ?? () => Navigator.maybePop(context),
      icon: Icon(widgetBackButtonIcon, size: 24),
      iconSize: 24,
      color: context.appTheme.colors.text,
      padding: EdgeInsets.zero,
      constraints: leadingIconButtonConstraints,
      // materialTapTargetSize: leadingIconButtonTapTargetSize,
    ) : null;

    // Resolves

    final resolvedActions = resolveActions(
      menuButton: menuButtonLocation == .actions ? widgetMenuButton : null,
      menuButtonPosition: menuButtonPosition,
      actions: appBarActions,
    );

    final resolvedLeading = resolveLeading(
      backButton: widgetBackButton,
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

    Widget drawerContent = AppSideMenu( 
      title: sideMenuTitle,
      origin: sideMenuOrigin,
      anchor: sideMenuAnchor,
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
        appBar: appBar
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
