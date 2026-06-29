import "package:flutter/material.dart"; 
import "package:flutter_first_app/widgets/layout/headers/_headers.dart" show MenuPosition, resolveActions;

class AppNavigationHeader extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool menu;
  final MenuPosition menuPosition;
  final List<Widget>? actions;

  const AppNavigationHeader({
    super.key,
    this.title = "",
    this.menu = true,
    this.menuPosition = MenuPosition.end,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    final resolvedActions = resolveActions(
      menu: menu,
      menuPosition: menuPosition,
      actions: actions,
    );

    return AppBar(
      // leading
      // title: const Text("Título", style: Theme.of(context).textTheme.displayMedium),
      title: Text(title, style: Theme.of(context).textTheme.displayMedium),
      actions: resolvedActions,
    );
  }
}
