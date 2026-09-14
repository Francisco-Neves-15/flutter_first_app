import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String? message;
  final bool requiredInteraction;

  const AppConfirmDialog({
    super.key,
    required this.title,
    this.message,
    this.requiredInteraction = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !requiredInteraction,
      child: AlertDialog(
        title: Text(title, style: context.appTheme.textStyles.h1),
        content: message != null ? Text(message!, style: context.appTheme.textStyles.body) : null,
        actions: [
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
        ],
      ),
    );
  }
}