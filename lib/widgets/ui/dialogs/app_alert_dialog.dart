import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/ui/dialogs/_dialogs.dart" show AppDialogsTypes;
import "package:flutter_first_app/widgets/ui/dialogs/app_dialog_utils.dart" show
  fAppDialogBuildMainColor,
  fAppDialogBuildIcon,
  fAppDialogBuildTitle,
  fAppDialogBuildActions
;

class AppAlertDialog extends StatelessWidget {

  /// Predefined Styles (Icons and Colors) for the Dialog;
  /// defines "title", "icon", and semantic colors (success, danger, etc.);
  /// can be overridden by the parameters: title & icon.
  /// By default, "standard" is used.
  final AppDialogsTypes? type;

  /// Title for the Dialog; by default, it uses the presets for the "type" parameter.
  final String? title;

  /// Optional message
  final String? message;

  /// Optional icon (widget)
  final Widget? icon;
  /// Show icon
  final bool showIcon;

  /// Determines whether clicking a dialog action is mandatory; E.g., the default "OK" action.
  /// When set to "true", it prevents the dialog from closing when clicking the barrier or using the native back button.
  final bool requiredInteraction;

  /// Custom actions for the 'actions' parameter; use the list of widgets;
  /// By default, use a TextButton | To close the dialog: () { Navigator.of(context).pop(); }
  final List<Widget>? actions;

  /// Actions layout flow (by deufalt, use Row)
  final AppAxisFlow? actionFlow;

  /// Makes every action occupy the full available width (see `buildActions`).
  final bool actionsFullWidth;

  const AppAlertDialog({
    super.key,
    this.type = AppDialogsTypes.standard,
    this.title,
    this.message,
    this.icon,
    this.showIcon = true,
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
        onPressed: () { Navigator.of(context).pop(); },
        // style: ElevatedButton.styleFrom(backgroundColor: rMainColor.color),
        // child: Text("OK", style: context.appTheme.textStyles.buttonText.copyWith(color: rMainColor.contrast)),
        child: Text("OK", style: context.appTheme.textStyles.buttonText),
      ),
    ];

    // Vars

    final rMainColor = fAppDialogBuildMainColor(context, type);
    final rActions = fAppDialogBuildActions(actionsList, actionFlow, actionsFullWidth: actionsFullWidth);

    final rIcon = fAppDialogBuildIcon(type);
    final rTitle = fAppDialogBuildTitle(type, title);
    final Widget? wMessage = message != null ? Text(message!, style: context.appTheme.textStyles.body) : null;

    final Widget wTitle = Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      spacing: AppMetrics.small,
      children: [
        if (showIcon) 
          if (icon != null) icon!
          else if (rIcon != null) Icon(rIcon, size: 32, color: rMainColor.color)
        ,
        Text(rTitle, style: context.appTheme.textStyles.h1.copyWith(color: rMainColor.color)),
      ],
    );

    return PopScope(
      canPop: !requiredInteraction,
      child: AlertDialog(
        title: wTitle,
        content: wMessage,
        actions: rActions
      ),
    );
  }
}
