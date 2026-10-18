import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/ui/button/app_button.dart";
import "package:flutter_first_app/widgets/ui/dialogs/_dialogs.dart" show AppDialogsTypes, AppDialogsMainActionVariants;
import "package:flutter_first_app/widgets/ui/dialogs/app_dialog_utils.dart" show
  fAppDialogBuildMainColor,
  fAppDialogBuildIcon,
  fAppDialogResolveShouldInvertDefaultActions,
  fAppDialogResolveActionsList,
  fAppDialogBuildActions,
  fAppDialogResolveMainActionButton
;

class AppConfirmDialog extends StatelessWidget {

  /// Predefined Styles (Icons and Colors) for the Dialog;
  /// defines "title", "icon", and semantic colors (success, danger, etc.);
  /// also modifies the style of the primary button (which defaults to the "confirm" button) using semantic styles;
  /// can be overridden by the parameters: title & icon.
  /// By default, "standard" is used.
  final AppDialogsTypes? type;

  /// Title for the Dialog
  final String title;

  /// Optional message
  final String? message;

  /// Optional icon (widget)
  final Widget? icon;
  /// Show icon
  final bool showIcon;

  /// Determines whether clicking a dialog action is mandatory; E.g., the defaults "Confirm" & "Cancel" actions.
  /// When set to "true", it prevents the dialog from closing when clicking the barrier or using the native back button.
  final bool requiredInteraction;

  /// Custom actions for the 'actions' parameter; use the list of widgets;
  /// By default, use:
  /// - TextButton     | To "cancel"  the dialog: () { Navigator.of(context).pop(false); }
  /// - AppButton | To "confirm" the dialog: () { Navigator.of(context).pop(true); }
  /// The "confirm" AppButton is the > main < action
  final List<Widget>? actions;

  final AppDialogsMainActionVariants? mainActionVariant;

  /// Actions layout flow (by deufalt, use Row)
  final AppAxisFlow? actionFlow;

  /// Makes every action occupy the full available width (see `buildActions`).
  final bool actionsFullWidth;

  /// need to write
  final bool invertDefaultActionsButtons;

  /// Custom Confirm text.
  final String? confirmText;

  /// Custom Cancel text.
  final String? cancelText;

  const AppConfirmDialog({
    super.key,
    this.type = AppDialogsTypes.standard,
    required this.title,
    this.message,
    this.icon,
    this.showIcon = true,
    this.requiredInteraction = false,
    this.actions,
    this.mainActionVariant = AppDialogsMainActionVariants.followDialogType,
    this.actionFlow = .row,
    this.actionsFullWidth = false,
    this.invertDefaultActionsButtons = false,
    this.confirmText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final rConfirmText = cancelText ?? l10n.common.confirm;
    final rCancelText = confirmText ?? l10n.common.cancel;

    final shouldInvertDefaultActions = fAppDialogResolveShouldInvertDefaultActions(actionFlow);

    final rMainActionButtonVariant = fAppDialogResolveMainActionButton(type, mainActionVariant);

    // Actions

    // Standard "Confirm" & "Cancel" (item)
    List<Widget>? defaultActionsList = [
      // default: cancel
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(invertDefaultActionsButtons ? true : false);
        },
        child: Text(invertDefaultActionsButtons ? rConfirmText : rCancelText, style: context.appTheme.textStyles.buttonText),
      ),
      // default: confirm
      AppButton(
        variant: rMainActionButtonVariant,
        onPressed: () {
          Navigator.of(context).pop(invertDefaultActionsButtons ? false : true);
        },
        child: Text(invertDefaultActionsButtons ? rCancelText : rConfirmText, style: context.appTheme.textStyles.buttonText),
      )
    ];

    // Standard "Confirm" & "Cancel" or action list
    List<Widget> actionsList = fAppDialogResolveActionsList(actions, defaultActionsList, shouldInvertDefaultActions);

    // Vars

    final rMainColor = fAppDialogBuildMainColor(context, type);
    final rActions = fAppDialogBuildActions(actionsList, actionFlow, actionsFullWidth: actionsFullWidth);

    final rIcon = fAppDialogBuildIcon(type);
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
        Text(title, style: context.appTheme.textStyles.h1.copyWith(color: rMainColor.color)),
      ],
    );

    // Continue

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