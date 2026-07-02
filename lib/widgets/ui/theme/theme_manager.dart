import "package:flutter/material.dart";
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;

class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {
        return TextButton(
          onPressed: () {}, 
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ))
          ),
          child: Row(
            children: [
              Text(ThemeController.instance.labelDisplay(context), style: context.appTheme.textStyles.buttonText,),
              Spacer(),
              Icon(Icons.keyboard_arrow_down_rounded)
            ],
          )
        );
      },
    );
  }
}
