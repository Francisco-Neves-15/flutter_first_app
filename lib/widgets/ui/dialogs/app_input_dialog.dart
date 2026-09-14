import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";

class AppInputDialog extends StatefulWidget {
  final String title;
  final String? message;
  final String? initialValue;
  final String? hintText;
  final String? confirmText;
  final String? cancelText;
  final bool requiredInteraction;

  const AppInputDialog({
    super.key,
    required this.title,
    this.message,
    this.initialValue,
    this.hintText,
    this.confirmText,
    this.cancelText,
    this.requiredInteraction = false,
  });

  @override
  State<AppInputDialog> createState() => _AppInputDialogState();
}

class _AppInputDialogState extends State<AppInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _cancel() {
    Navigator.of(context).pop();
  }

  void _confirm() {
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.requiredInteraction,
      child: AlertDialog(
        title: Text(widget.title, style: context.appTheme.textStyles.h1),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.message != null) ...[
              Text(widget.message!, style: context.appTheme.textStyles.body),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.hintText,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _cancel,
            child: Text(widget.cancelText ?? "Cancel", style: context.appTheme.textStyles.buttonText),
          ),
          ElevatedButton(
            onPressed: _confirm,
            child: Text(widget.confirmText ?? "Confirm", style: context.appTheme.textStyles.buttonText),
          ),
        ],
      ),
    );
  }
}
