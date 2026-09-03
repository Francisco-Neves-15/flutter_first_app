import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/widgets/layout/sidemenu/app_side_menu.dart" show SideMenuAnchorResolved;

class SideMenuListOption extends StatelessWidget {
  final VoidCallback? onPressed;

  final SideMenuAnchorResolved? anchor;

  final IconData? icon;
  final double? iconFill;

  final String? label;

  final bool? selected;

  const SideMenuListOption({ 
    super.key,
    this.onPressed,
    this.anchor,
    required this.icon,
    this.iconFill,
    required this.label,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {

    final mainColor = (selected != null && selected == true) ? context.appTheme.colors.primary : context.appTheme.colors.text;

    final rowContent = <Widget>[
      Text(label ?? "", style: context.appTheme.textStyles.buttonText.copyWith(color: mainColor)),
      Icon(icon, size: 32, fill: iconFill, color: mainColor),
    ];

    return TextButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ))
      ),
      onPressed: onPressed,
      child: Row(
        spacing: AppMetrics.small,
        mainAxisAlignment: anchor == .right ? .end : .start,
        crossAxisAlignment: .center,
        children: anchor == .right ? rowContent : rowContent.reversed.toList(),
      ),
    );
  }
}
