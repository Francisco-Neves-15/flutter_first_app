import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:material_symbols_icons/symbols.dart";

enum BottomSheetButtonPalette { text, textSecondary, danger }

class BottomSheetButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final BottomSheetButtonPalette palette;

  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? iconFill;

  final String label;
  final Color? labelColor;

  final bool? selected;

  const BottomSheetButton({
    super.key,
    this.onPressed,
    this.palette = BottomSheetButtonPalette.text,
    this.icon,
    this.iconColor,
    this.iconSize = 24,
    this.iconFill = 1,
    required this.label,
    this.labelColor,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {

    final Color colorPalette = switch (palette) {
      BottomSheetButtonPalette.text => context.appTheme.colors.text,
      BottomSheetButtonPalette.textSecondary => context.appTheme.colors.textSecondary,
      BottomSheetButtonPalette.danger => context.appTheme.colors.danger,
    };

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
          Text(
            label,
            style: context.appTheme.textStyles.buttonText.copyWith(color: labelColor ?? colorPalette),
          ),
          if (selected != null && selected == true) ...[
            Spacer(),
            Icon(Symbols.check_rounded)
          ],
        ],
      )
    );
  }
}
