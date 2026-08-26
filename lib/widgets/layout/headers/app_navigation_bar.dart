import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart"; 

class AppNavigationBar extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final List<Widget>? leading;
  final List<Widget>? actions;

  const AppNavigationBar({
    super.key,
    this.title,
    this.leading,
    this.actions
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title ?? "", style: context.appTheme.textStyles.h1) : null,
      actions: actions,
      // leading: Row(
      //   spacing: AppMetrics.extraLarge,
      //   children: [...leading ?? []]
      // ),
      // leading: Icon(Icons.abc),
    );
  }
}
