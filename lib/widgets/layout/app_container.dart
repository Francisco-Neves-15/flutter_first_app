import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

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
