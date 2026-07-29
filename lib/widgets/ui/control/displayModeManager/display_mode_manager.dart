import "package:flutter/material.dart";
import "package:flutter_first_app/docs/widgets/ui/displayModeManager/bad_usages.dart" show BadUsagesDisplayModeManager;
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/ui/control/displayModeManager/models.dart" show DisplayModeOption;

enum DisplayModeManagerType { segmented }

class DisplayModeManager<T> extends StatelessWidget {
  final DisplayModeManagerType mode;
  final List<DisplayModeOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool showIcon;
  final bool showLabel;
  final bool showSelectedIcon;
  final bool selectedIconReplaceMainIcon;

  const DisplayModeManager({
    super.key,
    this.mode = DisplayModeManagerType.segmented,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.showIcon = true,
    this.showLabel = false,
    this.showSelectedIcon = false,
    this.selectedIconReplaceMainIcon = false
  });

  @override
  Widget build(BuildContext context) {

    // Assert's

    assert(
      showIcon || showLabel,
      BadUsagesDisplayModeManager.e001.warn(),
    );

    assert(
      !showIcon || showLabel || !showSelectedIcon || !selectedIconReplaceMainIcon,
      BadUsagesDisplayModeManager.e002.warn(),
    );

    assert(
      showSelectedIcon || !selectedIconReplaceMainIcon,
      BadUsagesDisplayModeManager.e003.warn(),
    );

    assert(
      showIcon || !selectedIconReplaceMainIcon,
      BadUsagesDisplayModeManager.e004.warn(),
    );

    // Continue
  
    return SegmentedButton<T>(
      showSelectedIcon: showSelectedIcon,
      selected: {selected},
      onSelectionChanged: (selection) {
        if (selection.isNotEmpty) {
          onChanged(selection.first);
        }
      },

      segments: options.map((option) {
        final bool isSelected = option.value == selected;

        final Icon resolvedIcon = isSelected ? option.activeIcon : option.inactiveIcon;
        final Widget resolvedLabel = Text(option.label, style: context.appTheme.textStyles.buttonSmallText);

        Widget? buttonSegmentIcon;
        Widget? buttonSegmentLabel;

        if (showIcon) {
          if (showSelectedIcon) {
            if (selectedIconReplaceMainIcon) {
              buttonSegmentIcon = resolvedIcon;
              showLabel ? buttonSegmentLabel = resolvedLabel : buttonSegmentLabel = null;
            } else {
              buttonSegmentLabel = Row(
                spacing: AppMetrics.small,
                crossAxisAlignment: .center,
                mainAxisAlignment: .center,
                children: [
                  resolvedIcon,
                  if (showLabel) ...[resolvedLabel]
                ],
              );
            }
          } else {
            buttonSegmentIcon = resolvedIcon;
            showLabel ? buttonSegmentLabel = resolvedLabel : buttonSegmentLabel = null;
          }
        }

        if (!showIcon && showLabel) {
          buttonSegmentIcon = null;
          buttonSegmentLabel = resolvedLabel;
        }

        return ButtonSegment<T>(
          value: option.value,
          icon: buttonSegmentIcon,
          label: buttonSegmentLabel,
        );

      }).toList()

    );
  }
}
