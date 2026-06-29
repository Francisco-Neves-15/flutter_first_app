import "package:flutter/material.dart";
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode;

class AppLogo extends StatelessWidget {

  final AppAvailableThemeMode color;
  final double width;
  final double height;

  const AppLogo({
    super.key,
    this.color = AppAvailableThemeMode.auto,
    this.width = 32,
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {

    final logoLight = Image.asset("assets/images/easywatchlist-logo-black.png", width: width, height: height);
    final logoDark = Image.asset("assets/images/easywatchlist-logo-white.png", width: width, height: height);

    if (color == AppAvailableThemeMode.dark) {
      return logoLight;
    } else if (color == AppAvailableThemeMode.light) {
      return logoDark;
    } else {
      if (ThemeController.instance.isLight(context)) {
        return logoLight;
      } else {
        return logoDark;
      }
    }
  }

}
