import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show MenuPosition, resolveActions, resolveLeading;
import "package:flutter_first_app/widgets/ui/app_logo.dart" show AppLogo;

class AppHeader extends StatelessWidget {

  final String? title;
  final bool useMenu;
  final MenuPosition menuPosition;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    this.title,
    this.useMenu = true,
    this.menuPosition = MenuPosition.end,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {

    final resolvedActions = resolveActions(
      menu: useMenu,
      menuPosition: menuPosition,
      actions: actions,
    );

    final resolvedLeading = resolveLeading(
      logo: useMenu,
      logoWidget: AppLogo(height: 48, width: 48),
    );

    return SafeArea(child:
      Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: AppMetrics.base, vertical: AppMetrics.extraSmall),
        color: context.appTheme.colors.background,
        child: Row(
          spacing: AppMetrics.base,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(spacing: AppMetrics.small, children: resolvedLeading),
            Text(title ?? "<title-not-provided>", style: context.appTheme.textStyles.h1),
            Spacer(),
            Row(spacing: AppMetrics.small, children: resolvedActions),
          ],
        ),
      ),
    );
  }
}
