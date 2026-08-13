import "package:flutter/material.dart";
import "package:flutter_first_app/config/app_config_locales.dart" show AppAvailableLocale, AppLocaleFlags, AppLocaleAcronym, AppLocaleLabels;
import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_container.dart" show BottomSheetContainer;
import "package:flutter_svg/svg.dart" show SvgPicture;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;

class LangManagerLabel {
  final String flag;
  final String label;
  final String acronym;
  LangManagerLabel({
    required this.flag,
    required this.label,
    required this.acronym
  });
}

class LangManager extends StatelessWidget {

  const LangManager({super.key});

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final Widget resolvedLangManagerContent = ListenableBuilder(
      listenable: LangController.instance,
      builder: (context, _) { 
      return Column(
          spacing: AppMetrics.small,
          children: AppAvailableLocale.values.map((value) {
            return TextButton(
              onPressed: () => LangController.instance.setLocale(value),
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ))
              ),
              child: Row(
                spacing: AppMetrics.base,
                children: [
                  SvgPicture.asset(
                    AppLocaleFlags.of(value),
                    width: 32 * 1,
                    height: 32 * 0.75,
                    semanticsLabel: "${AppLocaleAcronym.of(value)} Flag",
                  ),
                  Text(AppLocaleLabels.of(value)),
                  if (LangController.instance.isCurrent(value)) ...[
                    Spacer(),
                    Icon(Symbols.check_rounded)
                  ]
                ],
              ),
            );
          }).toList(),
        );
      }
    );

    void open() async {
      showModalBottomSheet<void>(
        context: context,
        elevation: 0,
        builder: (_) => BottomSheetContainer(
          title: "App Language",
          description: "Select the language for the app",
          dismissListenable: LangController.instance,
          child: resolvedLangManagerContent,
        )
      );
    }

    return AnimatedBuilder(
      animation: LangController.instance,
      builder: (context, _) {

        // Resolving
        LangManagerLabel resolveLabel() {
          return LangManagerLabel(
            flag: AppLocaleFlags.of(LangController.instance.current),
            label: AppLocaleLabels.of(LangController.instance.current),
            acronym: AppLocaleLabels.of(LangController.instance.current)
          );
        }
        LangManagerLabel visibleLabel = resolveLabel();

        return Column(
          spacing: AppMetrics.extraSmall,
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Text(l10n.pageSettings.localeLabel, style: context.appTheme.textStyles.h3),
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
                      SvgPicture.asset(
                        visibleLabel.flag,
                        width: 32 * 1,
                        height: 32 * 0.75,
                        semanticsLabel: "${visibleLabel.acronym} Flag",
                      ),
                      Text(visibleLabel.label, style: context.appTheme.textStyles.buttonText),
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
