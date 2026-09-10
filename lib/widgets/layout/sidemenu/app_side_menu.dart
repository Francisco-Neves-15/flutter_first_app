import "package:flutter/material.dart";
import "package:material_symbols_icons/material_symbols_icons.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;

// Values
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisPositionHorizontal;
import "package:flutter_first_app/styles/app_metrics.dart";

// Screens
import "package:flutter_first_app/screens/home_screen.dart" show HomePage;
import "package:flutter_first_app/screens/settings_screen.dart" show SettingsScreen;

// Widgets
import "package:flutter_first_app/widgets/layout/sidemenu/side_list_option.dart" show SideMenuListOption;
import "package:flutter_first_app/widgets/ui/preferences/lang/lang_manager.dart";
import "package:flutter_first_app/widgets/ui/preferences/theme/theme_manager.dart";

// Navigation
import "package:flutter_first_app/navigation/app_routes.dart" show AppRoutes;
import "package:flutter_first_app/navigation/utils.dart" show isRouteSelected, navigateOrPopToRoute;

// Continue

enum SideMenuAnchor { left, right, origin }
enum SideMenuAnchorResolved { left, right }

class AppSideMenu extends StatelessWidget {

  final String? title;
  final AppAxisPositionHorizontal? origin;
  final SideMenuAnchor? anchor;
  final bool? safeArea;

  const AppSideMenu({ 
    super.key,
    this.title,
    this.origin,
    this.anchor,
    this.safeArea = true,
  });

  @override
  Widget build(BuildContext context) {

    final SideMenuAnchorResolved resolvedAnchor;

    SideMenuAnchorResolved resolveAnchor(SideMenuAnchor? iAnchor) {
      return switch (iAnchor) {
        null => origin == AppAxisPositionHorizontal.left ? .left : .right,
        SideMenuAnchor.left => .left,
        SideMenuAnchor.right => .right,
        SideMenuAnchor.origin => origin == AppAxisPositionHorizontal.left ? .left : .right,
      };
    }
    resolvedAnchor = resolveAnchor(anchor);

    final headerContent = <Widget>[
      if (title != null) ...[Text(title ?? "", style: context.appTheme.textStyles.h1)],
      Spacer(),
      IconButton(
        icon: Icon(Symbols.close_rounded),
        onPressed: () { Navigator.pop(context); },
      )
    ];

    Widget content = Drawer(
      child: Column(
        children: [

          // Header
          Container(
            height: 75,
            margin: .zero,
            padding: EdgeInsets.only(
              left: resolvedAnchor == .right ? AppMetrics.base : AppMetrics.small,
              right: resolvedAnchor == .left ? AppMetrics.base : AppMetrics.small
            ),
            child: Row(
              children: resolvedAnchor == .left ? headerContent.reversed.toList() : headerContent,
            ),
          ),

          // Body
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: AppMetrics.base),
              child: Column(
                // spacing: 8,
                mainAxisAlignment: .start,
                crossAxisAlignment: resolvedAnchor == .right ? .end : .start,
                children: [
                  SideMenuListOption(anchor: resolvedAnchor, icon: Symbols.phone, iconFill: 0, label: "Label 1", selected: false, onPressed: () => debugPrint("Teste"),),
                  SideMenuListOption(anchor: resolvedAnchor, icon: Symbols.phone, iconFill: 0, label: "Label 2", selected: false, onPressed: () => debugPrint("Teste"),),
                  // ----- Real navigation demo — see lib/navigation/README_NAVIGATION.md
                  SideMenuListOption(
                    anchor: resolvedAnchor,
                    icon: Symbols.home_rounded,
                    iconFill: isRouteSelected(context, AppRoutes.home) ? 1 : 0,
                    label: "Home",
                    selected: isRouteSelected(context, AppRoutes.home),
                    onPressed: () => navigateOrPopToRoute(
                      context,
                      routeName: AppRoutes.home,
                      builder: (_) => const HomePage(title: "WatchList"),
                    ),
                  ),
                  SideMenuListOption(
                    anchor: resolvedAnchor,
                    icon: Symbols.settings_rounded,
                    // includeSubRoutes: false — testing not treating
                    // "/settings/privacy" as still "inside" Configurações.
                    iconFill: isRouteSelected(context, AppRoutes.settings, includeSubRoutes: false) ? 1 : 0,
                    label: "Configurações",
                    selected: isRouteSelected(context, AppRoutes.settings, includeSubRoutes: false),
                    onPressed: () => navigateOrPopToRoute(
                      context,
                      routeName: AppRoutes.settings,
                      builder: (_) => const SettingsScreen(),
                    ),
                  ),
                  // -----
                  Spacer(),
                  SideMenuListOption(anchor: resolvedAnchor, icon: Symbols.phone, iconFill: 1, label: "Label 3", selected: true, onPressed: () => debugPrint("Teste"),),
                  SideMenuListOption(anchor: resolvedAnchor, icon: Symbols.phone, iconFill: 1, label: "Label 3", selected: true, onPressed: () => debugPrint("Teste"),),
                ],
              ),
            )
          ),

          // Footer
          Container(
            height: 75,
            margin: .zero,
            padding: EdgeInsets.only(
              left: resolvedAnchor == .right ? AppMetrics.base : AppMetrics.small,
              right: resolvedAnchor == .left ? AppMetrics.base : AppMetrics.small
            ),
            child: Row(
              mainAxisAlignment: .end,
              crossAxisAlignment: .center,
              spacing: 4,
              children: [
                LangManager(displayLayout: .icon),
                ThemeManager(displayLayout: .icon, optionsLayout: .segmented),
                SizedBox(width: AppMetrics.small)
              ],
            )
          ),

        ],
      ),
    );

    if (safeArea == true) {
      content = SafeArea(
        child: content,
      );
    }

    return content;

  }
}
