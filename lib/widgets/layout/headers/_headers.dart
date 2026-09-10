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
  Widget? backButton,
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

  // Back button always leads, ahead of the logo/menu button — platform
  // convention (and independent of `menuButtonPosition`, which is only
  // about the menu button's own placement).
  if (backButton != null) {
    resolvedLeading.insert(0, backButton);
  }

  return resolvedLeading;
}
