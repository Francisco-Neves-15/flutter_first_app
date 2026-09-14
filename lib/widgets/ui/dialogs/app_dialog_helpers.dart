import "package:flutter/material.dart";

import "app_alert_dialog.dart";
import "app_confirm_dialog.dart";
import "app_input_dialog.dart";

Future<void> showAppAlertDialog(
  BuildContext context, {
  AppAlertDialogType type = AppAlertDialogType.standard,
  String? message,
  bool requiredInteraction = false,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: !requiredInteraction,
    builder: (_) => AppAlertDialog(
      type: type,
      message: message,
      requiredInteraction: requiredInteraction,
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
