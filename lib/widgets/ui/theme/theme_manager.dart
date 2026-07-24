import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/_models.dart" show ActionSheetBuilderItem;
import "package:flutter_first_app/widgets/layout/bottomsheets/actionsheet_builder.dart" show ActionSheetBuilder;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_container.dart" show BottomSheetDismissType, BottomSheetContainer;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode, AppAvailableThemeBrightness, AppThemeIcons, AppThemeLabels;

enum ThemeManagerDisplayType { pill, list }

class ThemeManagerLabel {
  final IconData icon;
  final String text;
  ThemeManagerLabel({
    required this.icon,
    required this.text
  });
}

class ThemeManager extends StatelessWidget {
  final ThemeManagerDisplayType displayType;

  const ThemeManager({
    super.key,
    this.displayType = ThemeManagerDisplayType.list,
  });

  @override
  Widget build(BuildContext context) {

    final Widget resolvedThemeManagerContent = switch (displayType) {
      ThemeManagerDisplayType.list => (
        ActionSheetBuilder(
          showDividers: false,
          actions: [
            ActionSheetBuilderItem(
              icon: AppThemeIcons.auto,
              label: AppThemeLabels.auto,
              onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.auto); },
            ),
            ActionSheetBuilderItem(
              icon: AppThemeIcons.light,
              label: AppThemeLabels.light,
              onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.light); },
            ),
            ActionSheetBuilderItem(
              icon: AppThemeIcons.dark,
              label: AppThemeLabels.dark,
              onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.dark); },
            ),
          ],
        )
      ),
      ThemeManagerDisplayType.pill => (Text("pill version in progress..."))
    };

    void open() async {
      showModalBottomSheet<void>(
        context: context,
        elevation: 0,
        builder: (_) => BottomSheetContainer(
          title: "Tema do Aplicativo",
          description: "Selecione o tema para o aplicativo",
          dismissType: BottomSheetDismissType.back,
          child: resolvedThemeManagerContent
        ),
      );
    }

    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) {

        // Resolving
        ThemeManagerLabel resolveLabel() {
          // light
          if (ThemeController.instance.mode == AppAvailableThemeMode.light) {
            return ThemeManagerLabel( icon: AppThemeIcons.light, text: AppThemeLabels.light );
          }
          // dark
          else if (ThemeController.instance.mode == AppAvailableThemeMode.dark) {
            return ThemeManagerLabel( icon: AppThemeIcons.dark, text: AppThemeLabels.dark );
          }
          // auto
          else if (ThemeController.instance.mode == AppAvailableThemeMode.auto) {
            // auto-light
            if (ThemeController.instance.resolvedBrightness(context) == AppAvailableThemeBrightness.light) {
              return ThemeManagerLabel( icon: AppThemeIcons.autoLight, text: AppThemeLabels.autoLight );
            }
            // auto-dark
            else {
              return ThemeManagerLabel( icon: AppThemeIcons.autoDark, text: AppThemeLabels.autoDark );
            }
          }
          // no resolved (error)
          else {
            return ThemeManagerLabel( icon: AppThemeIcons.undetected, text: AppThemeLabels.undetected );
          }
        }
        ThemeManagerLabel visibleLabel = resolveLabel();

        return TextButton(
          onPressed: open,
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
