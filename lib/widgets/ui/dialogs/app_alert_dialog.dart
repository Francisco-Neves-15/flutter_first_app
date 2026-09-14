import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:material_symbols_icons/symbols.dart" show Symbols;

enum AppAlertDialogType {
  standard,
  success,
  danger,
  warn,
  info,
  error,
}

class AppAlertDialog extends StatelessWidget {
  final AppAlertDialogType? type;
  final String? message;
  final bool requiredInteraction;

  const AppAlertDialog({
    super.key,
    this.type = AppAlertDialogType.standard,
    this.message,
    this.requiredInteraction = false,
  });

  Widget? _buildIcon() {
    switch (type) {
      case AppAlertDialogType.standard:
        return null;
      case AppAlertDialogType.success:
        return const Icon(Symbols.check_circle_rounded);
      case AppAlertDialogType.danger:
        return const Icon(Symbols.dangerous_rounded);
      case AppAlertDialogType.warn:
        return const Icon(Symbols.warning_amber_rounded);
      case AppAlertDialogType.info:
        return const Icon(Symbols.info_rounded);
      case AppAlertDialogType.error:
        return const Icon(Symbols.error_rounded);
      case _:
        return const Icon(Symbols.question_mark_rounded);
    }
  }

  String _buildTitle() {
    switch (type) {
      case AppAlertDialogType.standard:
        return "Alerta";
      case AppAlertDialogType.success:
        return "Success";
      case AppAlertDialogType.danger:
        return "Danger";
      case AppAlertDialogType.warn:
        return "Attention";
      case AppAlertDialogType.info:
        return "Info";
      case AppAlertDialogType.error:
        return "Error";
      case _:
        return "?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !requiredInteraction,
      child: AlertDialog(
        icon: _buildIcon(),
        title: Text(
          _buildTitle(),
          style: context.appTheme.textStyles.h1,
        ),
        content: message != null ? Text(message!, style: context.appTheme.textStyles.body) : null,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK", style: context.appTheme.textStyles.buttonText,),
          ),
        ],
      ),
    );
  }
}
