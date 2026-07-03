import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode, AppAvailableThemeBrightness, AppThemeIcons;

class ThemeManagerLabel {
  final IconData icon;
  final String text;
  ThemeManagerLabel({required this.icon, required this.text});
}

class ThemeManager extends StatelessWidget {
  const ThemeManager({ super.key });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {

        // Resolving
        ThemeManagerLabel resolveLabel() {
          // light
          if (ThemeController.instance.mode == AppAvailableThemeMode.light) {
            return ThemeManagerLabel( icon: AppThemeIcons.light, text: "Light" );
          }
          // dark
          else if (ThemeController.instance.mode == AppAvailableThemeMode.dark) {
            return ThemeManagerLabel( icon: AppThemeIcons.dark, text: "Dark" );
          }
          // auto
          else if (ThemeController.instance.mode == AppAvailableThemeMode.auto) {
            // auto-light
            if (ThemeController.instance.resolvedBrightness(context) == AppAvailableThemeBrightness.light) {
              return ThemeManagerLabel( icon: AppThemeIcons.autoLight, text: "Autodetect (Light)" );
            }
            // auto-dark
            else {
              return ThemeManagerLabel( icon: AppThemeIcons.autoDark, text: "Autodetect (Dark)" );
            }
          }
          // no resolved (error)
          else {
            return ThemeManagerLabel( icon: AppThemeIcons.undetected, text: "Not detected (error)" );
          }
        }
        ThemeManagerLabel visibleLabel = resolveLabel();

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
              Row(
                spacing: AppMetrics.small, 
                children: [
                  Icon(visibleLabel.icon, size: 24, fill: 1),
                  Text(visibleLabel.text, style: context.appTheme.textStyles.buttonText),
                ]
              ),
              Spacer(),
              Icon(Symbols.keyboard_arrow_down_rounded, size: 24)
            ],
          )
        );
      },
    );
  }
}
