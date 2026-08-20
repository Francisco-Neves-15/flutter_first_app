import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/_models.dart" show ActionSheetBuilderItem;
import "package:flutter_first_app/widgets/layout/bottomsheets/action_sheet_builder.dart" show ActionSheetBuilder;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottom_sheet_container.dart" show BottomSheetContainer;
import "package:flutter_first_app/widgets/ui/preferences/theme/theme_manager_option_button_segment.dart" show ThemeManagerOptionButtonSegment;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/config/app_config_themes.dart" show AppAvailableThemeBrightness, AppAvailableThemeMode, AppThemeIcons, AppThemeLabels, appThemeIcon;

enum ThemeManagerDisplayLayout { icon, block }
enum ThemeManagerOptionsLayout { segmented, list }

class ThemeManagerLabel {
  final IconData icon;
  final double fillIcon;
  final String text;
  ThemeManagerLabel({
    required this.icon,
    required this.fillIcon,
    required this.text
  });
}

class ThemeManager extends StatelessWidget {
  final ThemeManagerDisplayLayout displayLayout;
  final ThemeManagerOptionsLayout optionsLayout;

  const ThemeManager({
    super.key,
    this.displayLayout = ThemeManagerDisplayLayout.block,
    this.optionsLayout = ThemeManagerOptionsLayout.list,
  });

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;

    // & Design Choice &: when ThemeController is in auto mode,
    // The designer decides whether the automatic mode icon should be filled.
    const double fillThemeAutoIcon = 0;

    final Widget resolvedThemeManagerContent = ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) { 
        final bool isAuto = ThemeController.instance.isAuto(context);
        final bool isLight = ThemeController.instance.isLight(context);
        final bool isDark = ThemeController.instance.isDark(context);
        return switch (optionsLayout) {
          ThemeManagerOptionsLayout.list => (
            ActionSheetBuilder(
              actions: [
                ActionSheetBuilderItem(
                  icon: AppThemeIcons.auto,
                  iconFill: fillThemeAutoIcon,
                  label: AppThemeLabels.auto,
                  onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.auto); },
                  selected: isAuto,
                ),
                ActionSheetBuilderItem(
                  icon: AppThemeIcons.light,
                  iconFill: isLight ? 1 : 0,
                  label: AppThemeLabels.light,
                  onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.light); },
                  selected: isLight
                ),
                ActionSheetBuilderItem(
                  icon: AppThemeIcons.dark,
                  iconFill: isDark ? 1 : 0,
                  label: AppThemeLabels.dark,
                  onPressed: () { ThemeController.instance.setTheme(AppAvailableThemeMode.dark); },
                  selected: isDark
                ),
              ],
            )
          ),
          ThemeManagerOptionsLayout.segmented =>
            Container(
              margin: EdgeInsetsGeometry.directional(top: AppMetrics.small, bottom: AppMetrics.base),
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
                      iconFill: fillThemeAutoIcon,
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
          title: l10n.pageSettings.themeTitle,
          description: l10n.pageSettings.themeDescription,
          showDividerHeader: false,
          headInfoLayout: .large,
          dismissLocation: .footer,
          showDividerFooter: true,
          showDismiss: true,
          /// Close after selection (off)
          // dismissListenable: ThemeController.instance,
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
            return ThemeManagerLabel( fillIcon: 1, icon: AppThemeIcons.light, text: AppThemeLabels.light );
          }
          // dark
          else if (ThemeController.instance.mode == AppAvailableThemeMode.dark) {
            return ThemeManagerLabel( fillIcon: 1, icon: AppThemeIcons.dark, text: AppThemeLabels.dark );
          }
          // auto
          else if (ThemeController.instance.mode == AppAvailableThemeMode.auto) {
            // auto-light
            if (ThemeController.instance.resolvedBrightness(context) == AppAvailableThemeBrightness.light) {
              return ThemeManagerLabel( fillIcon: fillThemeAutoIcon, icon: AppThemeIcons.autoLight, text: AppThemeLabels.autoLight );
            }
            // auto-dark
            else {
              return ThemeManagerLabel( fillIcon: fillThemeAutoIcon, icon: AppThemeIcons.autoDark, text: AppThemeLabels.autoDark );
            }
          }
          // no resolved (error)
          else {
            return ThemeManagerLabel( fillIcon: 1, icon: AppThemeIcons.undetected, text: AppThemeLabels.undetected );
          }
        }
        ThemeManagerLabel visibleLabel = resolveLabel();

        final Widget themeManagerLayout = switch(displayLayout) {
          ThemeManagerDisplayLayout.icon =>
            IconButton(
              onPressed: open,
              icon: Icon(appThemeIcon, fill: 1, size: 32, color: context.appTheme.colors.text)
            )
          ,
          ThemeManagerDisplayLayout.block => 
            Column(
              spacing: AppMetrics.small,
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  spacing: AppMetrics.small,
                  children: [
                    Icon(appThemeIcon, fill: 1, size: 32, color: context.appTheme.colors.text),
                    Text(l10n.pageSettings.localeLabel, style: context.appTheme.textStyles.h3),
                  ]
                ),
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
                          Icon(visibleLabel.icon, size: 24, fill: ThemeController.instance.mode == AppAvailableThemeMode.auto ? fillThemeAutoIcon : 1),
                          Text(visibleLabel.text, style: context.appTheme.textStyles.buttonText),
                        ]
                      ),
                      Spacer(),
                      Icon(Symbols.keyboard_arrow_down_rounded, size: 24)
                    ],
                  )
                )
              ],
            )
        };

        return themeManagerLayout;
      }
    );
  }
}
