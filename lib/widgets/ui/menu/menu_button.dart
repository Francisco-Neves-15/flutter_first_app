import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;

class MenuButton extends StatelessWidget {

  const MenuButton({ super.key });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu_rounded),
      iconSize: 32,
      color: context.appTheme.colors.text,
    );
  }

}
