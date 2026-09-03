import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisPositionHorizontal;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/widgets/layout/sidemenu/side_list_option.dart" show SideMenuListOption;
import "package:flutter_first_app/widgets/ui/preferences/lang/lang_manager.dart";
import "package:flutter_first_app/widgets/ui/preferences/theme/theme_manager.dart";
import "package:material_symbols_icons/material_symbols_icons.dart";

enum SideMenuAnchor { left, right, origin }
enum SideMenuAnchorResolved { left, right }

class AppSideMenu extends StatelessWidget {

  final String? title;
  final AppAxisPositionHorizontal? origin;
  final SideMenuAnchor? anchor;

  const AppSideMenu({ 
    super.key,
    this.title,
    this.origin,
    this.anchor,
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

    return Drawer(
      child: Column(
        children: [

          // Header
          Container(
            height: 75,
            margin: .zero,
            padding: EdgeInsets.only(
              top: AppMetrics.small,
              bottom: AppMetrics.small,
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
                  SideMenuListOption(anchor: resolvedAnchor, icon: Symbols.phone, iconFill: 1, label: "Label 3", selected: true, onPressed: () => debugPrint("Teste"),),
                  Spacer(),
                  Row(
                    mainAxisAlignment: .end,
                    crossAxisAlignment: .center,
                    spacing: 4,
                    children: [
                      LangManager(displayLayout: .icon),
                      ThemeManager(displayLayout: .icon, optionsLayout: .segmented),
                      SizedBox(width: AppMetrics.small)
                    ],
                  )
                ],
              ),
            )
          )

        ],
      ),
    );
  }
}
