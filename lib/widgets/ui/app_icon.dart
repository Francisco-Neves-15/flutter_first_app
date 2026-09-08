import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";

class AppIcon extends StatelessWidget {

  final IconData icon;
  final double? size;
  final Color? color;
  final double? fill;

  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.fill,
  });

  @override
  Widget build(BuildContext context) {

    final defaultIconStyle = IconThemeData(
      size: 24,
      color: context.appTheme.colors.text,
      fill: 0
    );

    return Icon(
      icon,
      size: size ?? defaultIconStyle.size,
      color: color ?? defaultIconStyle.color,
      fill: fill ?? defaultIconStyle.fill,
    );
  }
}
