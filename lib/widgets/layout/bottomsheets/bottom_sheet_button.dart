import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:material_symbols_icons/symbols.dart";

enum ActionSheetButtonPalette { text, textSecondary, danger }

class BottomSheetButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final ActionSheetButtonPalette? palette;

  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? iconFill;

  final String? label;
  final Color? labelColor;

  final bool? selected;

  const BottomSheetButton({
    super.key,
    this.onPressed,
    this.palette = ActionSheetButtonPalette.text,
    this.icon,
    this.iconColor,
    this.iconSize = 24,
    this.iconFill = 1,
    this.label,
    this.labelColor,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {

    final Color colorPalette = switch (palette) {
      ActionSheetButtonPalette.text => context.appTheme.colors.text,
      ActionSheetButtonPalette.textSecondary => context.appTheme.colors.textSecondary,
      ActionSheetButtonPalette.danger => context.appTheme.colors.danger,
      null => context.appTheme.colors.text,
    };

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        )),
      ),
      child: 
      Row(
        spacing: AppMetrics.extraSmall / 2,
        children: [
          // icon
          if (icon != null) ...[
            Icon(icon, size: iconSize, fill: iconFill, color: iconColor ?? colorPalette),
            const SizedBox(width: AppMetrics.small),
          ],
          // label
          if (label != null) ...[
            Text(
              label ?? "",
              style: context.appTheme.textStyles.buttonText.copyWith(color: labelColor ?? colorPalette),
            )
          ],
          if (selected != null && selected == true) ...[
            Spacer(),
            Icon(Symbols.check_rounded)
          ],
        ],
      )
    );
  }
}
