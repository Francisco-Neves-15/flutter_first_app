import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/widgets/ui/dialogs/app_dialog_utils.dart" show buildActions;

class AppConfirmDialog extends StatelessWidget {

  /// Title for the Dialog
  final String title;

  /// Optional message
  final String? message;

  /// Determines whether clicking a dialog action is mandatory; E.g., the defaults "Confirm" & "Cancel" actions.
  /// When set to "true", it prevents the dialog from closing when clicking the barrier or using the native back button.
  final bool requiredInteraction;

  /// Custom actions for the 'actions' parameter; use the list of widgets;
  /// By default, use:
  /// - TextButton     | To "cancel"  the dialog: () { Navigator.of(context).pop(false); }
  /// - ElevatedButton | To "confirm" the dialog: () { Navigator.of(context).pop(true); }
  final List<Widget>? actions;

  /// Actions layout flow (by deufalt, use Row)
  final AppAxisFlow? actionFlow;

  /// Makes every action occupy the full available width (see `buildActions`).
  final bool actionsFullWidth;

  const AppConfirmDialog({
    super.key,
    required this.title,
    this.message,
    this.requiredInteraction = false,
    this.actions,
    this.actionFlow = .row,
    this.actionsFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {

    // Actions
    
    // Standard "OK" or action list
    List<Widget>? actionsList = actions ?? [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: Text("Cancel", style: context.appTheme.textStyles.buttonText),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: Text("Confirm", style: context.appTheme.textStyles.buttonText),
      ),
    ];

    // Vars

    final rActions = buildActions(actionsList, actionFlow, actionsFullWidth: actionsFullWidth);
    final Widget wTitle = Text(title, style: context.appTheme.textStyles.h1);
    final Widget? wMessage = message != null ? Text(message!, style: context.appTheme.textStyles.body) : null;

    return PopScope(
      canPop: !requiredInteraction,
      child: AlertDialog(
        title: wTitle,
        content: wMessage,
        actions: rActions,
      ),
    );

  }
}