import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

class ThemeManagerOptionButtonSegment extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final IconData icon;
  final String label;
  const ThemeManagerOptionButtonSegment({
    super.key,
    this.margin = const EdgeInsetsGeometry.all(0),
    required this.icon,
    required this.label
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: EdgeInsetsGeometry.directional(top: AppMetrics.baseSmall, bottom: AppMetrics.small, start: AppMetrics.extraSmall, end: AppMetrics.extraSmall),
      child: Column(
        spacing: AppMetrics.extraSmall,
        children: [
          Icon(icon, size: 24, fill: 1),
          Text(label, style: context.appTheme.textStyles.buttonText)
        ]
      ),
    );
  }
}
