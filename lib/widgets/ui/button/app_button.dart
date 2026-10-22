import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/docs/widgets/ui/button/bad_usages.dart" show BadUsagesAppButton;
import "package:flutter_first_app/styles/app_metrics.dart";
import "package:flutter_first_app/utils/utils_style.dart" show OverlayEffect;

/// Defines the visual style of the button.
enum AppButtonType {
  /// A filled button with a background color.
  elevated,
  /// A button with a visible border and transparent background.
  outlined,
  /// A button with no visible background or border.
  text
}

/// Defines the semantic color variant of the button.
enum AppButtonVariant {
  primary,
  secondary,
  neutral,
  danger,
  success,
  warning,
  info,
  error,
}

/// A reusable button that supports multiple styles, color variants,
/// interaction callbacks, and status handling.
class AppButton extends StatelessWidget {

  /// Defines the button's visual structure.
  final AppButtonType type;

  /// Defines the button's semantic color scheme.
  final AppButtonVariant variant;

  /// The widget displayed inside the button.
  final Widget child;

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

  /// Whether the button displays a loading indicator.
  final bool? loading;

  /// Whether the loading indicator hides the content (child) when it is visible.
  final bool? loadingOverridesChild;

  /// Whether the button is disabled.
  final bool? disabled;

  const AppButton({
    super.key,
    this.type = AppButtonType.elevated,
    this.variant = AppButtonVariant.primary,
    required this.child,
    this.style,
    this.onPressed,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
    this.loading = false,
    this.loadingOverridesChild = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {

    final String badUsagesTextButton001 = BadUsagesAppButton.e001.warn();

    // Build

    Widget? rChild;
    Widget finalAppButton;

    /// Determines whether the button should be interactive.
    final bool isNonInteractive = disabled == true || loading == true;
    final bool isLoading = loading == true;
    final bool isDisabled = disabled == true;

    final VoidCallback? effectiveOnPressed                = isNonInteractive ? null : onPressed;
    final ValueChanged<bool>? effectiveOnFocusChange      = isNonInteractive ? null : onFocusChange;
    final void Function(bool isHovered)? effectiveOnHover = isNonInteractive ? null : onHover;
    final VoidCallback? effectiveOnLongPress              = isNonInteractive ? null : onLongPress;

    // Styles

    // dart format off
    Color resolveColorMain(AppButtonVariant inVariant) {
      switch (inVariant) {
        case AppButtonVariant.primary:   return context.appTheme.colors.primary;
        case AppButtonVariant.secondary: return context.appTheme.colors.text;
        case AppButtonVariant.neutral:   return context.appTheme.colors.neutral;
        case AppButtonVariant.danger:    return context.appTheme.colors.danger;
        case AppButtonVariant.success:   return context.appTheme.colors.success;
        case AppButtonVariant.warning:   return context.appTheme.colors.warn;
        case AppButtonVariant.info:      return context.appTheme.colors.info;
        case AppButtonVariant.error:     return context.appTheme.colors.error;
      }
    }
    // dart format on

    // dart format off
    Color resolveColorMainContrast(AppButtonVariant inVariant) {
      switch (inVariant) {
        case AppButtonVariant.primary:   return context.appTheme.colors.primaryContrast;
        case AppButtonVariant.secondary: return context.appTheme.colors.textInverted;
        case AppButtonVariant.neutral:   return context.appTheme.colors.neutralContrast;
        case AppButtonVariant.danger:    return context.appTheme.colors.dangerContrast;
        case AppButtonVariant.success:   return context.appTheme.colors.successContrast;
        case AppButtonVariant.warning:   return context.appTheme.colors.warnContrast;
        case AppButtonVariant.info:      return context.appTheme.colors.infoContrast;
        case AppButtonVariant.error:     return context.appTheme.colors.errorContrast;
      }
    }
    // dart format on

    // dart format off
    ButtonStyle resolveButtonStyle({
      required AppButtonType inType,
      required AppButtonVariant inVariant,
      required Color inColorMain,
      required Color inColorMainContrast
    }) {

      OverlayEffect overlayEffectColor = OverlayEffect(color: Colors.black, value: 0.25);
      if (inVariant == AppButtonVariant.secondary) {
        overlayEffectColor = OverlayEffect(color: Colors.white, value: 0.10);
      }

      switch (inType) {

        // AppButtonType.elevated
        case AppButtonType.elevated:
          return ButtonStyle(

            backgroundColor: WidgetStatePropertyAll(inColorMain),
            iconColor: WidgetStatePropertyAll(inColorMainContrast),
            foregroundColor: WidgetStatePropertyAll(inColorMainContrast),

            // Effect (Darker)
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                return Color.lerp(inColorMain, overlayEffectColor.color, overlayEffectColor.value);
              }
              return null;
            }),

          );

        // AppButtonType.outlined
        case AppButtonType.outlined:

          Color borderColor = inColorMain;
          if (inVariant == AppButtonVariant.secondary) {
            borderColor = context.appTheme.colors.border;
          }

          return ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            iconColor: WidgetStatePropertyAll(inColorMain),
            foregroundColor: WidgetStatePropertyAll(inColorMain),
            side: WidgetStatePropertyAll(
              BorderSide(color: borderColor, width: 1, strokeAlign: BorderSide.strokeAlignInside),
            ),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32)
            )),

            // Effect (slight background color)
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                return inColorMain.withValues(alpha: 0.15);
              }
              return null;
            }),

          );

        // AppButtonType.text
        case AppButtonType.text:
          return ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            iconColor: WidgetStatePropertyAll(inColorMain),
            foregroundColor: WidgetStatePropertyAll(inColorMain),

            // Effect (slight background color)
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                return inColorMain.withValues(alpha: 0.15);
              }
              return null;
            }),

          );
      }
    }
    // dart format on

    // dart format off
    ButtonStyle? resolveInteractiveButtonStyle({
      required bool inIsDisabled,
      required bool inIsLoading,
      required AppButtonType inType,
      required AppButtonVariant inVariant,
      required Color inColorMain,
      required Color inColorMainContrast
    }) {

      switch (inType) {

        case AppButtonType.elevated:

          if (inIsDisabled) {
            return ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(inColorMain.withValues(alpha: 0.50)),
              foregroundColor: WidgetStatePropertyAll(inColorMainContrast.withValues(alpha: 0.75)),
            );
          } else if (inIsLoading) {
            return ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(inColorMain.withValues(alpha: 0.90)),
              foregroundColor: WidgetStatePropertyAll(inColorMainContrast.withValues(alpha: 1)),
            );
          }

        case AppButtonType.outlined:

          Color borderColor = inColorMain;
          if (inVariant == AppButtonVariant.secondary) {
            borderColor = context.appTheme.colors.border;
          }

          if (inIsDisabled) {
            return ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(inColorMain.withValues(alpha: 0.50)),
              foregroundColor: WidgetStatePropertyAll(inColorMainContrast.withValues(alpha: 0.75)),
              side: WidgetStatePropertyAll(
                BorderSide(color: borderColor.withValues(alpha: 0.50), width: 1, strokeAlign: BorderSide.strokeAlignInside),
              ),
            );
          } else if (inIsLoading) {
            return ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(inColorMain.withValues(alpha: 0.90)),
              foregroundColor: WidgetStatePropertyAll(inColorMainContrast.withValues(alpha: 1)),
              side: WidgetStatePropertyAll(
                BorderSide(color: borderColor.withValues(alpha: 0.90), width: 1, strokeAlign: BorderSide.strokeAlignInside),
              ),
            );
          }

        case AppButtonType.text:

          if (inIsDisabled) {
            return ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(inColorMainContrast.withValues(alpha: 0.75)),
            );
          } else if (inIsLoading) {
            return ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(inColorMainContrast.withValues(alpha: 1)),
            );
          }

      }

      return null;

    }
    // dart format on

    // Button

    // dart format off
    Widget resolveButtonType({
      required AppButtonType inType,
      required ButtonStyle inButtonStyle,
      required ButtonStyle? inInteractiveButtonStyle,
      required Widget inResolvedChild,
    }) {

      // base: resolveButtonStyle() < interactive state: copyWith() < dev customization: copyWith()
      final ButtonStyle finalStyle = inButtonStyle.merge(inInteractiveButtonStyle).merge(style);

      switch (inType) {
        // AppButtonType.elevated
        case AppButtonType.elevated:
          return ElevatedButton(
            onPressed: effectiveOnPressed,
            onFocusChange: effectiveOnFocusChange,
            onHover: effectiveOnHover,
            onLongPress: effectiveOnLongPress,
            style: finalStyle,
            child: null,
          );
        // AppButtonType.outlined
        case AppButtonType.outlined:
          return OutlinedButton(
            onPressed: effectiveOnPressed,
            onFocusChange: effectiveOnFocusChange,
            onHover: effectiveOnHover,
            onLongPress: effectiveOnLongPress,
            style: finalStyle,
            child: inResolvedChild,
          );

        // AppButtonType.text
        case AppButtonType.text:
          return TextButton(
            onPressed: effectiveOnPressed,
            onFocusChange: effectiveOnFocusChange,
            onHover: effectiveOnHover,
            onLongPress: effectiveOnLongPress,
            style: finalStyle,
            child: inResolvedChild ?? Text(badUsagesTextButton001),
          );
      }
    }
    // dart format on

    // Resolving Main Theme

    Color rColorMain = resolveColorMain(variant);
    Color rColorMainContrast = resolveColorMainContrast(variant);

    // Resolving Loading

    Widget loadingIndicator = SizedBox(
      width: 16,
      height: 16,
      // CircularProgressIndicator || LinearProgressIndicator
      child: LinearProgressIndicator(
        // strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(rColorMainContrast)
      ),
    );

    // Resolving Child

    // rChild = isLoading ?
    //   (loadingOverridesChild == true && child ? 
    //     loadingIndicator : 
    //     Row(
    //       spacing: AppMetrics.extraSmall,
    //       children: [
    //         loadingIndicator, 
    //         if (child != null) child
    //       ],
    //     )
    //   ) : child;

    // Resolving Button Style

    ButtonStyle rButtonStyle = resolveButtonStyle(
      inType: type,
      inVariant: variant,
      inColorMain: rColorMain,
      inColorMainContrast: rColorMainContrast
    );

    ButtonStyle? rInteractiveButtonStyle = resolveInteractiveButtonStyle(
      inIsDisabled: isDisabled,
      inIsLoading: isLoading,
      inType: type,
      inVariant: variant,
      inColorMain: rColorMain,
      inColorMainContrast: rColorMainContrast
    );

    finalAppButton = resolveButtonType(
      inType: type,
      inButtonStyle: rButtonStyle,
      inInteractiveButtonStyle: rInteractiveButtonStyle,
      // inResolvedChild: rChild
      inResolvedChild: child
    );

    return finalAppButton;

  }

}