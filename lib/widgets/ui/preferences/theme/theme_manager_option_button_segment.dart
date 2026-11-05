import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_spacing.dart" show AppSpacing;

class ThemeManagerOptionButtonSegment extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final IconData icon;
  final String label;
  final double? iconFill;
  const ThemeManagerOptionButtonSegment({
    super.key,
    this.margin = const EdgeInsetsGeometry.all(0),
    required this.icon,
    required this.label,
    this.iconFill = 1
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsetsGeometry.directional(top: AppSpacing.baseSmall, bottom: AppSpacing.small, start: AppSpacing.extraSmall, end: AppSpacing.extraSmall),
      child: Column(
        spacing: AppSpacing.extraSmall,
        children: [
          Icon(icon, size: 24, fill: iconFill ?? 1),
          Text(label, style: context.appTheme.textStyles.buttonText)
        ]
      ),
    );
  }
}
