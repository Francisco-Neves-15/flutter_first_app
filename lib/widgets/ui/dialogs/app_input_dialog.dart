import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/widgets/ui/dialogs/app_dialog_utils.dart" show
  fAppDialogResolveShouldInvertDefaultActions,
  fAppDialogResolveActionsList,
  fAppDialogBuildActions
;

class AppInputDialog extends StatefulWidget {

  /// Title for the Dialog
  final String title;

  /// Optional message
  final String? message;

  /// Initial value displayed in the input.
  ///
  /// This is independent from [defaultReturnValue].
  final String? initialValue;

  /// Value returned when the dialog is dismissed without a value.
  ///
  /// This is different from [initialValue]: the user can edit or erase
  /// the initial value, while this value is used only when the result
  /// would otherwise be null.
  final dynamic defaultReturnValue;

  /// Hint text displayed inside the input.
  final String? hintText;

  /// Determines whether the dialog must remain open until the user
  /// explicitly interacts with one of its actions.
  ///
  /// When true:
  /// - barrier dismissal is disabled;
  /// - native back dismissal is disabled;
  /// - the Confirm action requires a non-empty value.
  ///
  /// Cancel is still available.
  final bool requiredInteraction;

  /// Determines whether the input itself is mandatory.
  ///
  /// When true:
  /// - barrier dismissal is disabled;
  /// - native back dismissal is disabled;
  /// - Confirm requires a non-empty value;
  /// - Cancel is removed.
  final bool requiredInput;

  /// Optional validation function.
  ///
  /// The function receives the current input value and must return true
  /// when the value is valid.
  /// 
  /// Examples:
  /// - String: `(value) => value.length > 3`
  /// - Int: `(value) => value == 3`
  /// - Double: `(value) => value > 3.5`
  /// - Bool: `(value) => value == true`
  final bool Function(dynamic value)? validator;

  /// Flutter input type.
  ///
  /// Examples:
  /// - TextInputType.text
  /// - TextInputType.number
  /// - TextInputType.phone
  /// - TextInputType.emailAddress
  final TextInputType inputType;

  /// Custom actions for the 'actions' parameter; use the list of widgets;
  /// By default, use:
  /// - TextButton     | To "cancel"  the input: _cancel()
  /// - ElevatedButton | To "confirm" the input: _confirm()
  /// The "confirm" ElevatedButton is the > main < action
  final List<Widget>? actions;

  /// Actions layout flow (by default, Row).
  final AppAxisFlow? actionFlow;

  /// Makes every action occupy the full available width.
  final bool actionsFullWidth;

  /// need to write
  final bool invertDefaultActionsButtons;

  /// Custom Confirm text.
  final String? confirmText;

  /// Custom Cancel text.
  final String? cancelText;

  const AppInputDialog({
    super.key,
    required this.title,
    this.message,
    this.initialValue,
    this.defaultReturnValue,
    this.hintText,
    this.requiredInteraction = false,
    this.requiredInput = false,
    this.validator,
    this.inputType = TextInputType.text,
    this.actions,
    this.actionFlow = .row,
    this.actionsFullWidth = false,
    this.invertDefaultActionsButtons = false,
    this.confirmText,
    this.cancelText,
  });

  @override
  State<AppInputDialog> createState() => _AppInputDialogState();
}

class _AppInputDialogState extends State<AppInputDialog> {
  late final TextEditingController _controller;

  bool get _hasValue => _controller.text.trim().isNotEmpty;

  bool get _isValid {
    if (!_hasValue) {
      return false;
    }

    if (widget.validator == null) {
      return true;
    }

    return widget.validator!(_controller.text);
  }

  bool get _canConfirm {
    // If the input is required, a value is mandatory.
    if (widget.requiredInput || widget.requiredInteraction) {
      return _isValid;
    }

    // If it isn't required and there is no validator,
    // an empty value is allowed.
    if (widget.validator == null) {
      return true;
    }

    // If a validator exists, it must pass.
    return widget.validator!(_controller.text);
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue,
    );

    _controller.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onInputChanged);
    _controller.dispose();

    super.dispose();
  }

  void _onInputChanged() {
    setState(() {});
  }

  dynamic _resolveReturnValue(String? value) {
    final resolvedValue = value ?? widget.defaultReturnValue;

    if (resolvedValue == null) {
      return null;
    }

    return _convertValue(resolvedValue);
  }

  dynamic _convertValue(String value) {
    switch (widget.inputType) {

      case TextInputType.number:
        return double.tryParse(value);

      case TextInputType.phone:
      case TextInputType.text:
      case TextInputType.emailAddress:
      case TextInputType.datetime:
      case TextInputType.multiline:
      case TextInputType.url:
      case TextInputType.visiblePassword:
      default:
        return value;

    }
  }

  void _cancel() {
    Navigator.of(context).pop(
      _resolveReturnValue(null),
    );
  }

  void _confirm() {
    if (!_canConfirm) {
      return;
    }

    Navigator.of(context).pop(
      _resolveReturnValue(_controller.text),
    );
  }

  List<TextInputFormatter> _resolveInputFormatters() {

    if (widget.inputType == TextInputType.number) {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r"[0-9.]"),
        ),
      ];
    }

    if (widget.inputType == TextInputType.phone) {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(r"[0-9+\-() ]"),
        ),
      ];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;

    final rConfirmText = widget.cancelText ?? l10n.common.confirm;
    final rCancelText = widget.confirmText ?? l10n.common.cancel;

    final shouldInvertDefaultActions = fAppDialogResolveShouldInvertDefaultActions(widget.actionFlow);

    final defaultActionsList = <Widget>[
      // default: cancel
      if (!widget.requiredInput) ...[
        TextButton(
          onPressed: widget.invertDefaultActionsButtons ? _confirm : _cancel,
          child: Text(widget.invertDefaultActionsButtons ? rConfirmText : rCancelText, style: context.appTheme.textStyles.buttonText)
        )
      ],
      // default: confirm
      ElevatedButton(
        onPressed: _canConfirm ? (widget.invertDefaultActionsButtons ? _cancel : _confirm) : null,
        child: Text(widget.invertDefaultActionsButtons ? rCancelText : rConfirmText, style: context.appTheme.textStyles.buttonText),
      )
    ];

    final actionsList = fAppDialogResolveActionsList(widget.actions, defaultActionsList, shouldInvertDefaultActions);
    final rActions = fAppDialogBuildActions(actionsList, widget.actionFlow, actionsFullWidth: widget.actionsFullWidth);
    final wTitle = Text(widget.title, style: context.appTheme.textStyles.h1);
    final wMessage = widget.message != null ? Text(widget.message!, style: context.appTheme.textStyles.body) : null;

    final wContent = <Widget>[
      if (wMessage != null) ...[wMessage],
      TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: widget.inputType,
        inputFormatters: _resolveInputFormatters(),
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
      ),
    ];

    return PopScope(
      canPop: !widget.requiredInteraction && !widget.requiredInput,
      child: AlertDialog(
        title: wTitle,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppMetrics.base,
          children: wContent,
        ),
        actions: rActions,
      ),
    );

  }
}
