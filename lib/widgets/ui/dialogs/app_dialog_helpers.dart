import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/widgets/ui/dialogs/_dialogs.dart" show AppDialogsTypes, AppDialogsMainActionVariants;

import "app_alert_dialog.dart" show AppAlertDialog;
import "app_confirm_dialog.dart" show AppConfirmDialog;
import "app_input_dialog.dart" show AppInputDialog;

/// See: AppAlertDialog (lib\widgets\ui\dialogs\app_alertdialog.dart) for more information about the parameters.
Future<void> showAppAlertDialog(
  BuildContext context, {
  AppDialogsTypes type = AppDialogsTypes.standard,
  String? title,
  String? message,
  Widget? icon,
  bool showIcon = true,
  bool requiredInteraction = false,
  List<Widget>? actions,
  AppAxisFlow? actionFlow,
  bool actionsFullWidth = false,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppAlertDialog(
      type: type,
      title: title,
      message: message,
      requiredInteraction: requiredInteraction,
      actions: actions,
      actionFlow: actionFlow,
      actionsFullWidth: actionsFullWidth,
      icon: icon,
      showIcon: showIcon,
    ),
  );
}

/// See: AppConfirmDialog (lib\widgets\ui\dialogs\app_confirm_dialog.dart) for more information about the parameters.
Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  AppDialogsTypes type = AppDialogsTypes.standard,
  required String title,
  String? message,
  Widget? icon,
  bool showIcon = true,
  bool requiredInteraction = false,
  bool nullReturnFalse = false,
  List<Widget>? actions,
  AppDialogsMainActionVariants mainActionVariant = .followDialogType,
  AppAxisFlow? actionFlow,
  bool actionsFullWidth = false,
  bool invertDefaultActionsButtons = false,
  String? confirmText,
  String? cancelText,
}) async {
  final result = await showDialog<bool?>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppConfirmDialog(
      type: type,
      title: title,
      message: message,
      requiredInteraction: requiredInteraction,
      actions: actions,
      mainActionVariant: mainActionVariant,
      actionFlow: actionFlow,
      actionsFullWidth: actionsFullWidth,
      invertDefaultActionsButtons: invertDefaultActionsButtons,
      confirmText: confirmText,
      cancelText: cancelText,
      icon: icon,
      showIcon: showIcon,
    ),
  );

  if (result == null && nullReturnFalse) {
    return false;
  }

  return result;
}

/// See: AppInputDialog (lib\widgets\ui\dialogs\app_input_dialog.dart) for more information about the parameters.
Future<String?> showAppInputDialog(
  BuildContext context, {
  required String title,
  String? message,
  String? initialValue,
  dynamic defaultReturnValue,
  String? hintText,
  String? confirmText,
  String? cancelText,
  bool requiredInteraction = false,
  bool requiredInput = false,
  bool Function(dynamic value)? validator,
  TextInputType inputType = TextInputType.text,
  List<Widget>? actions,
  AppAxisFlow? actionFlow,
  bool actionsFullWidth = false,
}) {
  return showDialog<String?>(
    context: context,
    barrierDismissible: !requiredInteraction && !requiredInput,
    builder: (_) => AppInputDialog(
      title: title,
      message: message,
      initialValue: initialValue,
      defaultReturnValue: defaultReturnValue,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      requiredInteraction: requiredInteraction,
      requiredInput: requiredInput,
      validator: validator,
      inputType: inputType,
      actions: actions,
      actionFlow: actionFlow,
      actionsFullWidth: actionsFullWidth,
    ),
  );
}
