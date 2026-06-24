import "package:flutter/material.dart";
import "package:first_app_and_simple_tutorial/styles/app_metrics.dart";

class AppContainer extends StatelessWidget {
  final Widget content;
  final bool autoPadding;
  final EdgeInsetsGeometry? padding;

  const AppContainer({
    super.key,
    required this.content,
    this.autoPadding = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          (autoPadding
              ? const EdgeInsets.all(AppMetrics.base)
              : EdgeInsets.zero),
      child: content,
    );
  }
}
