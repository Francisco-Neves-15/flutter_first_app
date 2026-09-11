import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:material_symbols_icons/symbols.dart" show Symbols;

enum AlertsAlertType {
  standard,
  success,
  danger,
  warn,
  info,
  error
}

class AlertDialogContent extends StatelessWidget {

  final AlertsAlertType? type;
  final String? message;

  const AlertDialogContent({
    super.key,
    this.type = AlertsAlertType.standard,
    this.message,
  });

  Widget? _buildIcon() {
    switch (type) {

      case AlertsAlertType.standard:
        return null;

      case AlertsAlertType.success:
        return const Icon(Symbols.check_circle_rounded);

      case AlertsAlertType.danger:
        return const Icon(Symbols.dangerous_rounded);

      case AlertsAlertType.warn:
        return const Icon(Symbols.warning_amber_rounded);

      case AlertsAlertType.info:
        return const Icon(Symbols.info_rounded);

      case AlertsAlertType.error:
        return const Icon(Symbols.error_rounded);

      case _:
        return const Icon(Symbols.question_mark_rounded);

    }
  }

  String _buildTitle() {
    switch (type) {

      case AlertsAlertType.standard:
        return "Alerta";

      case AlertsAlertType.success:
        return "Success";

      case AlertsAlertType.danger:
        return "Danger";

      case AlertsAlertType.warn:
        return "Attention";

      case AlertsAlertType.info:
        return "Info";

      case AlertsAlertType.error:
        return "Error";

      case _:
        return "?";

    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: _buildIcon(),
      title: Text(_buildTitle(), style: context.appTheme.textStyles.h1),
      content: message != null ? Text(message ?? "", style: context.appTheme.textStyles.body) : null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK", style: context.appTheme.textStyles.buttonText),
        ),
      ],
    );
  }

}
