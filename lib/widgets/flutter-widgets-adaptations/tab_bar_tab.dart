import 'package:flutter/material.dart';

class TabBarTab extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final EdgeInsetsGeometry? iconMargin;
  final double? height;
  final Widget? child;

  const TabBarTab({
    super.key,
    this.text,
    this.icon,
    this.iconMargin,
    this.height = 24,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: text,
      icon: icon,
      iconMargin: iconMargin,
      height: height,
      child: child,
    );
  }
}