import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisPosition;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

class AppContainer extends StatelessWidget {
  final Widget content;

  final bool autoPadding;
  final EdgeInsetsGeometry? padding;
  final List<AppAxisPosition>? paddingExclude;

  const AppContainer({
    super.key,
    required this.content,
    this.autoPadding = false,
    this.padding,
    this.paddingExclude,
  });

@override
  Widget build(BuildContext context) {

    final customPadding = padding?.resolve(Directionality.of(context));

    final double baseTop = customPadding?.top ?? (autoPadding ? AppMetrics.base : 0.0);
    final double baseBottom = customPadding?.bottom ?? (autoPadding ? AppMetrics.base : 0.0);
    final double baseLeft = customPadding?.left ?? (autoPadding ? AppMetrics.base : 0.0);
    final double baseRight = customPadding?.right ?? (autoPadding ? AppMetrics.base : 0.0);

    bool isExcluded(AppAxisPosition position) {
      return paddingExclude?.contains(position) ?? false;
    }

    final EdgeInsets resolvedPadding = EdgeInsets.only(
      top: isExcluded(AppAxisPosition.top) ? 0.0 : baseTop,
      bottom: isExcluded(AppAxisPosition.bottom) ? 0.0 : baseBottom,
      left: isExcluded(AppAxisPosition.left) ? 0.0 : baseLeft,
      right: isExcluded(AppAxisPosition.right) ? 0.0 : baseRight,
    );

    if (resolvedPadding == EdgeInsets.zero) {
      return content;
    }

    return Container(
      padding: resolvedPadding,
      child: content,
    );
  }
}
