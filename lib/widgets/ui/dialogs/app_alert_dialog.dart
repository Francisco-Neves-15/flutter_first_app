import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/styles/app_metrics.dart";
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

  /// Predefined Styles (Icons and Colors) for the Dialog;
  /// defines "title", "icon", and semantic colors (success, danger, etc.);
  /// can be overridden by the parameters: title & title.
  /// By default, "standard" is used.
  final AppAlertDialogType? type;

  /// Title for the Dialog; by default, it uses the presets for the "type" parameter.
  final String? title;

  /// Optional message
  final String? message;

  /// Optional icon (widget)
  final Widget? icon;
  /// Show icon
  final bool showIcon;

  /// Determines whether clicking a dialog action is mandatory; E.g., the default "OK" action.
  /// When set to "true", it prevents the dialog from closing when clicking the barrier or using the native back button.
  final bool requiredInteraction;

  /// Custom actions for the 'actions' parameter; use the list of widgets;
  /// By default, use a TextButton | To close the dialog: () { Navigator.of(context).pop(); }
  final List<Widget>? actions;

  const AppAlertDialog({
    super.key,
    this.type = AppAlertDialogType.standard,
    this.title,
    this.message,
    this.icon,
    this.showIcon = true,
    this.requiredInteraction = false,
    this.actions,
  });

  IconData? _buildIcon() {
    switch (type) {
      case AppAlertDialogType.standard:
        return null;
      case AppAlertDialogType.success:
        return Symbols.check_circle_rounded;
      case AppAlertDialogType.danger:
        return Symbols.dangerous_rounded;
      case AppAlertDialogType.warn:
        return Symbols.warning_amber_rounded;
      case AppAlertDialogType.info:
        return Symbols.info_rounded;
      case AppAlertDialogType.error:
        return Symbols.error_rounded;
      case _:
        return Symbols.question_mark_rounded;
    }
  }

  String _buildTitle() {
    if (title != null) return title!;
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

    // Helpers

    // Style Color
    ({Color color, Color contrast}) buildMainColor(AppAlertDialogType? inType) {
      switch (inType) {
        case AppAlertDialogType.standard:
          return (
            color: context.appTheme.colors.primary,
            contrast: context.appTheme.colors.primaryContrast,
          );
        case AppAlertDialogType.success:
          return (
            color: context.appTheme.colors.success,
            contrast: context.appTheme.colors.successContrast,
          );
        case AppAlertDialogType.danger:
          return (
            color: context.appTheme.colors.danger,
            contrast: context.appTheme.colors.dangerContrast,
          );
        case AppAlertDialogType.warn:
          return (
            color: context.appTheme.colors.warn,
            contrast: context.appTheme.colors.warnContrast,
          );
        case AppAlertDialogType.info:
          return (
            color: context.appTheme.colors.info,
            contrast: context.appTheme.colors.infoContrast,
          );
        case AppAlertDialogType.error:
          return (
            color: context.appTheme.colors.error,
            contrast: context.appTheme.colors.errorContrast,
          );
        case _:
          return (
            color: context.appTheme.colors.neutral,
            contrast: context.appTheme.colors.neutralContrast,
          );
      }
    }

    // Actions
    
    // Standard "OK" or action list
    List<Widget>? rActions = actions ?? [
      TextButton(
        onPressed: () { Navigator.of(context).pop(); },
        // style: ElevatedButton.styleFrom(backgroundColor: rMainColor.color),
        // child: Text("OK", style: context.appTheme.textStyles.buttonText.copyWith(color: rMainColor.contrast)),
        child: Text("OK", style: context.appTheme.textStyles.buttonText),
      ),
    ];

    final rMainColor = buildMainColor(type);
    final rIcon = _buildIcon();
    final rTitle = _buildTitle();

    final Widget wTitle = Row(
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      spacing: AppMetrics.small,
      children: [
        if (showIcon) 
          if (icon != null) icon!
          else if (rIcon != null) Icon(rIcon, size: 32, color: rMainColor.color)
        ,
        Text(rTitle, style: context.appTheme.textStyles.h1.copyWith(color: rMainColor.color)),
      ],
    );

    return PopScope(
      canPop: !requiredInteraction,
      child: AlertDialog(
        title: wTitle,
        content: message != null ? Text(message!, style: context.appTheme.textStyles.body) : null,
        actions: rActions,
      ),
    );
  }
}
