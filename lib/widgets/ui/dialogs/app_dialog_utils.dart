import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/styles/app_metrics.dart";

/// [actionsFullWidth] makes every action occupy the full available width,
/// splitting it (and `spacing`) evenly with the other actions.
/// - `.row`: wraps each action in `Expanded` — the row's main axis (width)
///   is bounded (`OverflowBar` sizes it to the dialog's width), so flex
///   works normally.
/// - `.column`: wraps each action in `SizedBox(width: double.infinity)`,
///   NOT `Expanded` — `OverflowBar` gives a single wrapped child unbounded
///   height, so an `Expanded` there (flexing the column's main axis, which
///   is vertical) has no finite height to divide and throws ("Cannot hit
///   test a render box with no size"). `SizedBox` only needs the width
///   constraint, which stays bounded either way.
List<Widget>? buildActions(
  AppAxisFlow? actionFlow,
  List<Widget> actionsList, {
  bool actionsFullWidth = false,
}) {

  final resolvedActionsList = !actionsFullWidth ? actionsList : [
    for (final action in actionsList)
      actionFlow == AppAxisFlow.column
          ? SizedBox(width: double.infinity, child: action)
          : Expanded(child: action),
  ];

  if (actionFlow == AppAxisFlow.column) {
    return [
      Column(
        mainAxisAlignment: .end,
        crossAxisAlignment: .end,
        spacing: AppMetrics.base,
        children: resolvedActionsList,
      )
    ];
  }

  return [
    Row(
      mainAxisAlignment: .end,
      crossAxisAlignment: .end,
      spacing: AppMetrics.small,
      children: resolvedActionsList,
    )
  ];

}
