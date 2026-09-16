import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;

import "app_alert_dialog.dart" show AppAlertDialog, AppAlertDialogType;
import "app_confirm_dialog.dart" show AppConfirmDialog;
import "app_input_dialog.dart" show AppInputDialog;

/// See: AppAlertDialog (lib\widgets\ui\dialogs\app_alertdialog.dart) for more information about the parameters.
Future<void> showAppAlertDialog(
  BuildContext context, {
  AppAlertDialogType type = AppAlertDialogType.standard,
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
      message: message,
      requiredInteraction: requiredInteraction,
      actions: actions,
      actionFlow: actionFlow,
      actionsFullWidth: actionsFullWidth,
      icon: icon,
      showIcon: showIcon,
      title: title,
    ),
  );
}

/// See: AppConfirmDialog (lib\widgets\ui\dialogs\app_confirm_dialog.dart) for more information about the parameters.
Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  String? message,
  bool requiredInteraction = false,
  bool nullReturnFalse = false,
  List<Widget>? actions,
  AppAxisFlow? actionFlow,
  bool actionsFullWidth = false,
}) async {
  final result = await showDialog<bool?>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppConfirmDialog(
      title: title,
      message: message,
      requiredInteraction: requiredInteraction,
      actions: actions,
      actionFlow: actionFlow,
      actionsFullWidth: actionsFullWidth,
    ),
  );

  if (result == null && nullReturnFalse) {
    return false;
  }

  return result;
}

Future<String?> showAppInputDialog(
  BuildContext context, {
  required String title,
  String? message,
  String? initialValue,
  String? hintText,
  String? confirmText,
  String? cancelText,
  bool requiredInteraction = false,
}) {
  return showDialog<String?>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppInputDialog(
      title: title,
      message: message,
      initialValue: initialValue,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      requiredInteraction: requiredInteraction,
    ),
  );
}
