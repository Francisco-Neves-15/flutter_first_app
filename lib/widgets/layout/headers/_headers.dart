import "package:flutter/material.dart" show Widget;

enum AppBarType { navigation, header }

enum MenuButtonLocation { leading, actions }
enum MenuButtonPosition { start, end }

List<Widget>? resolveActions({
  Widget? menuButton,
  MenuButtonPosition? menuButtonPosition,
  List<Widget>? actions,
}) {
  final resolvedActions = <Widget>[...?actions];

  if (menuButton != null) {
    final resolvedMenuButtonPosition = menuButtonPosition ?? MenuButtonPosition.end;
    switch (resolvedMenuButtonPosition) {
      case MenuButtonPosition.start: resolvedActions.insert(0, menuButton);
      case MenuButtonPosition.end: resolvedActions.add(menuButton);
    }
  }

  return resolvedActions;
}

List<Widget>? resolveLeading({
  Widget? logo,
  Widget? menuButton,
  MenuButtonPosition? menuButtonPosition,
}) {
  final resolvedLeading = <Widget>[];

  if (logo != null) {
    resolvedLeading.insert(0, logo);
  }

  if (menuButton != null) {
    final resolvedMenuButtonPosition = menuButtonPosition ?? MenuButtonPosition.end;
    switch (resolvedMenuButtonPosition) {
      case MenuButtonPosition.start: resolvedLeading.insert(0, menuButton);
      case MenuButtonPosition.end: resolvedLeading.add(menuButton);
    }
  }

  return resolvedLeading;
}
