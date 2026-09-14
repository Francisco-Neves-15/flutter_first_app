import "package:flutter/material.dart";

import "app_alert_dialog.dart";
import "app_confirm_dialog.dart";
import "app_input_dialog.dart";

/// See: AppAlertDialog (lib\widgets\ui\dialogs\app alertdialog.dart) for more information about the parameters.
Future<void> showAppAlertDialog(
  BuildContext context, {
  AppAlertDialogType type = AppAlertDialogType.standard,
  String? title,
  String? message,
  Widget? icon,
  bool showIcon = true,
  bool requiredInteraction = false,
  List<Widget>? actions,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppAlertDialog(
      type: type,
      message: message,
      requiredInteraction: requiredInteraction,
      actions: actions,
      icon: icon,
      showIcon: showIcon,
      title: title,
    ),
  );
}

Future<bool?> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  String? message,
  bool requiredInteraction = false,
  bool nullReturnFalse = false,
}) async {
  final result = await showDialog<bool?>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppConfirmDialog(
      title: title,
      message: message,
      requiredInteraction: requiredInteraction,
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
