import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/bottomsheets/_models.dart" show ActionSheetBuilderItem;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_button.dart" show BottomSheetButton;

class ActionSheetBuilder extends StatelessWidget {

  final List<ActionSheetBuilderItem> actions;
  final bool showDividers;

  const ActionSheetBuilder({
    super.key,
    required this.actions,
    this.showDividers = false,
  });

  @override
  Widget build(BuildContext context) {

    final visibleActions = actions
        .where((action) => action.show)
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        visibleActions.length,
        (index) {

          final action = visibleActions[index];

          final isLast = index == visibleActions.length - 1;


          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppMetrics.small,

            children: [

              BottomSheetButton(
                palette: action.palette,
                icon: action.icon,
                iconColor: action.iconColor,
                labelColor: action.labelColor,
                label: action.label,
                onPressed: action.onPressed,
              ),


              if (showDividers && !isLast)
                const Divider(
                  height: AppMetrics.small,
                ),
            ],
          );
        },
      ),
    );
  }
}
