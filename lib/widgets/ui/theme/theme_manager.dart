import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/_models.dart" show ActionSheetBuilderItem;
import "package:flutter_first_app/widgets/layout/bottomsheets/actionsheet_builder.dart" show ActionSheetBuilder;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_container.dart" show BottomSheetContainer;
import "package:flutter_first_app/widgets/ui/theme/theme_manager_option_button_segment.dart" show ThemeManagerOptionButtonSegment;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/config/app_config_themes.dart" show AppAvailableThemeMode, AppAvailableThemeBrightness, AppThemeIcons, AppThemeLabels;

enum ThemeManagerDisplayType { segmented, list }

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

    final l10n = context.l10n;

    final Widget resolvedThemeManagerContent = ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) { 
        return switch (displayType) {
          ThemeManagerDisplayType.list => (
            ActionSheetBuilder(
              actions: [
                ActionSheetBuilderItem(
                  icon: AppThemeIcons.auto,
                  label: AppThemeLabels.auto,
                  onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.auto); },
                  selected: ThemeController.instance.isAuto(context),
                ),
                ActionSheetBuilderItem(
                  icon: AppThemeIcons.light,
                  label: AppThemeLabels.light,
                  onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.light); },
                  selected: ThemeController.instance.isLight(context)
                ),
                ActionSheetBuilderItem(
                  icon: AppThemeIcons.dark,
                  label: AppThemeLabels.dark,
                  onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.dark); },
                  selected: ThemeController.instance.isDark(context)
                ),
              ],
            )
          ),
          ThemeManagerDisplayType.segmented => 
          Container(
            margin: EdgeInsetsGeometry.symmetric(vertical: AppMetrics.small),
            child: SegmentedButton<AppAvailableThemeMode>(
              segments: [
                ButtonSegment(
                  value: AppAvailableThemeMode.light,
                  // icon: Icon(AppThemeIcons.light, size: 20, fill: 1),
                  // label: Text(AppThemeLabels.light)
                  label: ThemeManagerOptionButtonSegment(
                    icon: AppThemeIcons.light,
                    label: AppThemeLabels.light,
                    margin: EdgeInsetsGeometry.directional(start: AppMetrics.small)
                  )
                ),
                ButtonSegment(
                  value: AppAvailableThemeMode.auto,
                  // icon: Icon(AppThemeIcons.auto, size: 20, fill: 1),
                  // label: Text(AppThemeLabels.auto)
                  label: ThemeManagerOptionButtonSegment(
                    icon: AppThemeIcons.auto,
                    label: AppThemeLabels.auto,
                  )
                ),
                ButtonSegment( value: AppAvailableThemeMode.dark,
                  // icon: Icon(AppThemeIcons.dark, size: 20, fill: 1),
                  // label: Text(AppThemeLabels.dark)
                  label: ThemeManagerOptionButtonSegment(
                    icon: AppThemeIcons.dark,
                    label: AppThemeLabels.dark,
                    margin: EdgeInsetsGeometry.directional(end: AppMetrics.small)
                  )
                )
              ],
              emptySelectionAllowed: false,
              selectedIcon: Icon(Symbols.check_rounded, size: 20, fill: 1),
              showSelectedIcon: false,
              selected: {ThemeController.instance.mode},
              onSelectionChanged: (selection) {
                ThemeController.instance.setTheme(selection.first);
              },
            )
          )
        };
      }
    );

    void open() async {
      showModalBottomSheet<void>(
        context: context,
        elevation: 0,
        builder: (_) => BottomSheetContainer(
          title: "App Appearance",
          description: "Select the theme for the app",
          child: resolvedThemeManagerContent
        )
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

        return Column(
          spacing: AppMetrics.extraSmall,
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Text(l10n.pageSettings.themeLabel, style: context.appTheme.textStyles.h3),
            TextButton(
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
            )
          ],
        );
      },
    );
  }
}
