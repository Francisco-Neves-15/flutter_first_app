import "package:flutter/material.dart";
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_button.dart";

class ActionSheetBuilderItem {
  final String label;

  final IconData? icon;

  final BottomSheetButtonPalette palette;

  final Color? iconColor;
  final Color? labelColor;

  final bool show;

  final VoidCallback? onPressed;

  const ActionSheetBuilderItem({
    required this.label,
    this.icon,
    this.palette = BottomSheetButtonPalette.text,
    this.iconColor,
    this.labelColor,
    this.show = true,
    this.onPressed,
  });
}