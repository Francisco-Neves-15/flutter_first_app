import "package:flutter/material.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_button.dart" show ActionSheetButtonPalette;

class ActionSheetBuilderItem {
  final ActionSheetButtonPalette palette;

  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double? iconFill;

  final String label;
  final Color? labelColor;

  final bool show;

  final VoidCallback? onPressed;

  final bool? selected;

  const ActionSheetBuilderItem({
    this.palette = ActionSheetButtonPalette.text,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.iconFill,
    required this.label,
    this.labelColor,
    this.show = true,
    this.onPressed,
    this.selected,
  });
}