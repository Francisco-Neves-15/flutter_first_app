import 'package:flutter/material.dart';
import 'package:flutter_first_app/widgets/ui/control/displayModeManager/display_mode_manage_option.dart' show DisplayModeOption;

class DisplayModeManager<T> extends StatelessWidget {
  final List<DisplayModeOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;

  final bool showLabel;
  final double? iconSize;

  const DisplayModeManager({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.showLabel = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      showSelectedIcon: false,
      selected: {selected},
      onSelectionChanged: (selection) {
        if (selection.isNotEmpty) {
          onChanged(selection.first);
        }
      },
      segments: options.map((option) {
        final bool isSelected = option.value == selected;
        return ButtonSegment<T>(
          value: option.value,
          icon: Icon(
            isSelected
                ? option.activeIcon
                : option.inactiveIcon,
            fill: isSelected ? 1 : 0,
            size: iconSize ?? 20,
          ),
          label: showLabel
              ? Text(option.label)
              : null,
        );
      }).toList(),
    );
  }
}