import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_axis.dart" show AppAxisFlow;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/ui/button/app_button.dart" show AppButtonVariant;
import "package:flutter_first_app/widgets/ui/dialogs/_dialogs.dart" show AppDialogsTypes, AppDialogsMainActionVariants;
import "package:material_symbols_icons/material_symbols_icons.dart" show Symbols;

// Standardization of Styles

IconData? fAppDialogBuildIcon(AppDialogsTypes? type) {
  switch (type) {
    case AppDialogsTypes.standard:
      return null;
    case AppDialogsTypes.success:
      return Symbols.check_circle_rounded;
    case AppDialogsTypes.danger:
      return Symbols.dangerous_rounded;
    case AppDialogsTypes.warn:
      return Symbols.warning_amber_rounded;
    case AppDialogsTypes.info:
      return Symbols.info_rounded;
    case AppDialogsTypes.error:
      return Symbols.error_rounded;
    case _:
      return Symbols.question_mark_rounded;
  }
}

String fAppDialogBuildTitle(AppDialogsTypes? type, String? title) {
  if (title != null) return title;
  switch (type) {
    case AppDialogsTypes.standard:
      return "Alerta";
    case AppDialogsTypes.success:
      return "Success";
    case AppDialogsTypes.danger:
      return "Danger";
    case AppDialogsTypes.warn:
      return "Attention";
    case AppDialogsTypes.info:
      return "Info";
    case AppDialogsTypes.error:
      return "Error";
    case _:
      return "?";
  }
}

// Style Color
({Color color, Color contrast}) fAppDialogBuildMainColor(BuildContext context, AppDialogsTypes? type) {
  switch (type) {
    case AppDialogsTypes.standard:
      return (
        color: context.appTheme.colors.primary,
        contrast: context.appTheme.colors.primaryContrast,
      );
    case AppDialogsTypes.success:
      return (
        color: context.appTheme.colors.success,
        contrast: context.appTheme.colors.successContrast,
      );
    case AppDialogsTypes.danger:
      return (
        color: context.appTheme.colors.danger,
        contrast: context.appTheme.colors.dangerContrast,
      );
    case AppDialogsTypes.warn:
      return (
        color: context.appTheme.colors.warn,
        contrast: context.appTheme.colors.warnContrast,
      );
    case AppDialogsTypes.info:
      return (
        color: context.appTheme.colors.info,
        contrast: context.appTheme.colors.infoContrast,
      );
    case AppDialogsTypes.error:
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

/// [actionsFullWidth] makes every action occupy the full available width,
/// splitting it (and `spacing`) evenly with the other actions.
/// - `.row`: wraps each action in `Expanded` — the row's main axis (width)
///   is bounded (`OverflowBar` sizes it to the dialog's width), so flex
///   works normally.
/// - `.column`: wraps each action in `SizedBox(width: double.infinity)`,
///   NOT `Expanded` — `OverflowBar` gives a single wrapped child unbounded
///   height, so an `Expanded` there (flexing the column's main axis, which
///   is vertical) has no finite height to divide and throws ("Cannot hit
///   test a render box with no size"). `SizedBox` only needs the width
///   constraint, which stays bounded either way.
List<Widget>? fAppDialogBuildActions(
  List<Widget> actionsList,
  AppAxisFlow? actionFlow,
  {
    bool actionsFullWidth = false,
  }
) {

  final resolvedActionsList = !actionsFullWidth ? actionsList : [
    for (final action in actionsList)
      actionFlow == AppAxisFlow.column
          ? SizedBox(width: double.infinity, child: action)
          : Expanded(child: action),
  ];

  if (actionFlow == AppAxisFlow.column) {
    return [
      Column(
        mainAxisAlignment: .end,
        crossAxisAlignment: .end,
        spacing: AppMetrics.base,
        children: resolvedActionsList,
      )
    ];
  }

  return [
    Row(
      mainAxisAlignment: .end,
      crossAxisAlignment: .end,
      spacing: AppMetrics.small,
      children: resolvedActionsList,
    )
  ];

}

//

AppButtonVariant fAppDialogResolveMainActionButton(
  AppDialogsTypes? dialogType,
  AppDialogsMainActionVariants? buttonType,
) {

  AppButtonVariant fAppDialogTypeToButtonVariant(AppDialogsTypes? type) {
    return switch (type) {
      .standard => .primary,
      .success => .success,
      .danger => .danger,
      .warn => .warning,
      .info => .info,
      .error => .error,
      _ => .primary
    };
  }

  AppButtonVariant fAppDialogActionToButtonVariant(AppDialogsMainActionVariants? type) {
    return switch (type) {
      .followDialogType => throw StateError('Unexpected followDialogType'),
      .standard => .primary,
      .success => .success,
      .danger => .danger,
      .warn => .warning,
      .info => .info,
      .error => .error,
      _ => .primary
    };
  }

  if (buttonType == .followDialogType) {
    return fAppDialogTypeToButtonVariant(dialogType);
  }

  return fAppDialogActionToButtonVariant(buttonType);

}

// Dev Handlers

bool fAppDialogResolveShouldInvertDefaultActions(
  AppAxisFlow? actionFlow
) {
  return actionFlow == AppAxisFlow.column;
}

List<Widget> fAppDialogResolveActionsList(
  List<Widget>? actions,
  List<Widget> defaultActionsList,
  bool shouldInvertDefaultActions
) {
  return actions ?? (shouldInvertDefaultActions ? defaultActionsList.reversed.toList() : defaultActionsList);
}
