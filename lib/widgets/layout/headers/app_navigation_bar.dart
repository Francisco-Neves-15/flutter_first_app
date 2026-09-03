import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show AppBarType;
import "package:flutter_first_app/widgets/ui/app_logo.dart" show getAppLogoSize; 

class AppNavigationBar extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final List<Widget>? leading;
  final List<Widget>? actions;
  final AppBarType? appBar;

  const AppNavigationBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.appBar
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final hasLeading = leading != null && leading!.isNotEmpty;

    const double paddingValue = AppMetrics.small;

    return AppBar(
      backgroundColor: context.appTheme.colors.background,
      title: title != null ? Text(title ?? "", style: context.appTheme.textStyles.h1) : null,
      actions: actions,
      actionsPadding: const EdgeInsets.only(right: paddingValue),
      automaticallyImplyLeading: false,
      leadingWidth: hasLeading ? _leadingWidth(leading!.length, appBar) : null,
      leading: hasLeading ? Padding(
        padding: const EdgeInsets.only(left: paddingValue),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppMetrics.small,
          children: leading!,
        ),
      ) : null
    );
  }

  static double _leadingWidth(int count, AppBarType? appBar) {
    final appLogoSize = getAppLogoSize(appBar);

    return (count * appLogoSize) +
        ((count - 1) * AppMetrics.small) +
        AppMetrics.small;
  }
}
