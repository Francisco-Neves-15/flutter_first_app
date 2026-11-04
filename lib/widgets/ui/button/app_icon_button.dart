import "package:flutter/material.dart";
import "package:flutter_first_app/widgets/ui/button/app_button.dart" show AppButtonType, AppButtonVariant;

/// Defines the aspect/format of the icon button.
enum AppIconButtonAspect {
  standard,
  squared
}

class AppIconButton extends StatelessWidget {

  /// Defines the button's visual structure.
  final AppButtonType type;

  /// Defines the button's semantic color scheme.
  final AppButtonVariant variant;

  /// Defines the aspect/format of the icon button.
  final AppIconButtonAspect aspect;

  /// The main widget displayed inside the button.
  final Widget icon;

  /// Overrides the default button style.
  final ButtonStyle? style;

  /// Called when the button is pressed.
  /// Set to null to disable the button's interaction.
  final VoidCallback? onPressed;

  /// Called when the button's focus state changes.
  final ValueChanged<bool>? onFocusChange;

  /// Called when the pointer enters or leaves the button.
  final void Function(bool isHovered)? onHover;

  /// Called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// Whether the button displays a `loading indicator`.
  final bool? loading;

  /// Whether the button is disabled.
  final bool? disabled;

  const AppIconButton({
    super.key,
    this.type = AppButtonType.elevated,
    this.variant = AppButtonVariant.primary,
    this.aspect = AppIconButtonAspect.standard,
    required this.icon,
    this.style,
    this.onPressed,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.loading = false,
    this.disabled = false
  });

  // TODO
  @override
  Widget build(BuildContext context) {
    return Text("AppIconButton");
  }
}