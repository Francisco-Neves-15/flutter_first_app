import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_svg/svg.dart" show SvgPicture;

class AppLogo extends StatelessWidget {

  final bool? useThemed;
  final Color? color;
  final double? width;
  final double? height;

  const AppLogo({
    super.key,
    this. useThemed,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {

    Color getColor() {
      if (context.appTheme.isLight) {
        return Color(0xFF000000);
      } else {
        return Color(0xFFFFFFFF);
      }
    }
    final Color rColor = getColor();

    final logoSvg = SvgPicture.asset(
      "assets/svg/easywatchlist-logo-1x1.svg",
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(
        rColor,
        BlendMode.srcIn
      ),
      semanticsLabel: "App Logo",
    );

    return logoSvg;
  }

}
