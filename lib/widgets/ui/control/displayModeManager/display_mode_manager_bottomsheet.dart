import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisDirectionHorizontal;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/bottomsheets/_models.dart" show ActionSheetBuilderItem;
import "package:flutter_first_app/widgets/layout/bottomsheets/action_sheet_builder.dart" show ActionSheetBuilder;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottom_sheet_container.dart" show BottomSheetContainer;
import "package:flutter_first_app/widgets/ui/control/displayModeManager/models.dart" show DisplayModeOption;
import "package:material_symbols_icons/symbols.dart" show Symbols;

class _DisplayModeBottomsheetContent<T> extends StatefulWidget {
  final List<DisplayModeOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool showLabel;
  final bool showIndicator;

  const _DisplayModeBottomsheetContent({
    required this.options,
    required this.selected,
    required this.onChanged,
    this.showLabel = true,
    this.showIndicator = true,
  });

  @override
  State<_DisplayModeBottomsheetContent<T>> createState() => _DisplayModeBottomsheetContentState<T>();
}

class _DisplayModeBottomsheetContentState<T> extends State<_DisplayModeBottomsheetContent<T>> {

  late T selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return ActionSheetBuilder(
      showDividers: false,
      actions: widget.options.map((option) {

        final bool isSelected = option.value == selected;

        final Icon resolvedIcon = isSelected ? option.activeIcon : option.inactiveIcon;

        return ActionSheetBuilderItem(
          icon: resolvedIcon.icon,
          iconColor: resolvedIcon.color,
          iconSize: resolvedIcon.size,
          iconFill: resolvedIcon.fill,
          label: option.label,
          selected: isSelected,
          onPressed: () {
            setState(() {
              selected = option.value;
            });
            widget.onChanged(option.value);
          },
        );

      }).toList(),
    );
  }
}

class DisplayModeManagerBottomsheet<T> extends StatelessWidget {
  final List<DisplayModeOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool showSelectedLabel;
  final bool showIndicator;
  final AppAxisDirectionHorizontal indicatorPosition;

  const DisplayModeManagerBottomsheet({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    this.showSelectedLabel = false,
    this.showIndicator = true,
    this.indicatorPosition = AppAxisDirectionHorizontal.start,
  });

  @override
  Widget build(BuildContext context) {

    final selectedOption = options.firstWhere(
      (option) => option.value == selected,
    );

    void open() async {
      showModalBottomSheet<void>(
        context: context,
        elevation: 0,
        builder: (_) => BottomSheetContainer(
          title: "Display mode",
          description: "Select the screen display mode",
          child: _DisplayModeBottomsheetContent<T>(
            options: options,
            selected: selected,
            onChanged: onChanged,
          )
        )
      );
    }

    final resolvedIndicatorIcon = Icon(Symbols.keyboard_arrow_down_rounded, size: 32, fill: 1);
    final indicatorOnStart = indicatorPosition == AppAxisDirectionHorizontal.start;

    return OutlinedButton(
      onPressed: open,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.only(
            top: AppMetrics.small,
            bottom: AppMetrics.small,
            // adaptive spacing for the "indicator" 
            // (chevron icon with internal horizontal padding that makes the button layout look disproportionate)
            left: indicatorOnStart ? AppMetrics.baseSmall : AppMetrics.base,
            right: !indicatorOnStart ? AppMetrics.baseSmall : AppMetrics.base,
          ),
        ),
      ),
        child: Row(
        mainAxisSize: .min,
        children: [
          Row(
            spacing: AppMetrics.small,
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              if (indicatorOnStart) ...[resolvedIndicatorIcon],
              selectedOption.activeIcon,
              if (showSelectedLabel) ...[Text(selectedOption.label, style: context.appTheme.textStyles.buttonText)],
              if (!indicatorOnStart) ...[resolvedIndicatorIcon],
            ],
          )
        ]
      )
    );

  }
}