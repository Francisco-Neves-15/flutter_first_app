import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_colors_extension.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show MenuPosition, resolveActions, resolveLeading;
import "package:flutter_first_app/widgets/ui/app_logo.dart" show AppLogo;

class AppHeader extends StatelessWidget {

  final String title;
  final bool menu;
  final MenuPosition menuPosition;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    this.title = "",
    this.menu = true,
    this.menuPosition = MenuPosition.end,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {

    final resolvedActions = resolveActions(
      menu: menu,
      menuPosition: menuPosition,
      actions: actions,
    );

    final resolvedLeading = resolveLeading(
      logo: menu,
      logoWidget: AppLogo(height: 48, width: 48),
    );

    return SafeArea(child:
      Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        color: context.colors.background,
        child: Row(
          spacing: AppMetrics.small,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(spacing: AppMetrics.small, children: resolvedLeading),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Spacer(),
            Row(spacing: AppMetrics.small, children: resolvedActions),
          ],
        ),
      ),
    );
  }
}
