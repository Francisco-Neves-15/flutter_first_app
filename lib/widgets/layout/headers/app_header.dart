import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_spacing.dart" show AppSpacing;

class AppHeader extends StatelessWidget {

  final String? title;
  final List<Widget>? leading;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {

    return SafeArea(child:
      Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base, vertical: AppSpacing.extraSmall),
        color: context.appTheme.colors.background,
        child: Row(
          spacing: AppSpacing.base,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(spacing: AppSpacing.small, children: leading ?? []),
            if (title != null) ...[Text(title ?? "", style: context.appTheme.textStyles.h1)],
            Spacer(),
            Row(spacing: AppSpacing.small, children: actions ?? []),
          ],
        ),
      ),
    );
  }
}
