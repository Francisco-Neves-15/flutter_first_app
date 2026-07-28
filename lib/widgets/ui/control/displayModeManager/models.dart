import "package:flutter/material.dart" show Icon;

enum DisplayModes { fallback, list, grid, listGrid }

class DisplayModeOption<T> {
  final T value;
  final Icon activeIcon;
  final Icon inactiveIcon;
  final String label;

  const DisplayModeOption({
    required this.value,
    required this.activeIcon,
    required this.inactiveIcon,
    this.label = "",
  });
}