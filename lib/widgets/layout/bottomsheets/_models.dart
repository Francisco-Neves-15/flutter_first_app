import "package:flutter/material.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/actionsheet_button.dart";

class ActionSheetItem {
  final String label;

  final IconData? icon;

  final ActionSheetButtonPalette palette;

  final Color? iconColor;
  final Color? labelColor;

  final bool show;

  final VoidCallback? onPressed;

  const ActionSheetItem({
    required this.label,
    this.icon,
    this.palette = ActionSheetButtonPalette.text,
    this.iconColor,
    this.labelColor,
    this.show = true,
    this.onPressed,
  });
}