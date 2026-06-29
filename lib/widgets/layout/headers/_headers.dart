import "package:flutter/material.dart" show Widget;
import "package:flutter_first_app/widgets/ui/menu/menu_button.dart" show MenuButton;

enum MenuPosition { start, end }

List<Widget> resolveActions({
  required bool menu,
  required MenuPosition menuPosition,
  List<Widget>? actions,
}) {
  final resolvedActions = <Widget>[...?actions];

  if (menu) {
    if (menuPosition == MenuPosition.start) {
      resolvedActions.insert(0, MenuButton());
    } else {
      resolvedActions.add(MenuButton());
    }
  }

  return resolvedActions;
}

List<Widget> resolveLeading({
  required bool logo,
  required Widget logoWidget,
}) {
  final resolvedLeading = <Widget>[];

  if (logo) {
    resolvedLeading.insert(0, logoWidget);
  }

  return resolvedLeading;
}
