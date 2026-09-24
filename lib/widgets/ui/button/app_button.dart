import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/theme_extension.dart";
import "package:flutter_first_app/docs/widgets/ui/button/bad_usages.dart" show BadUsagesAppButton;
import "package:flutter_first_app/utils/utils_style.dart" show OverlayEffect;

enum AppButtonType {
  elevated,
  outlined,
  text
}

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

class AppButton extends StatelessWidget {

  // Styles
  final AppButtonType type;
  final AppButtonVariant variant;

  // Button
  final Widget? child;
  final ButtonStyle? style;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onFocusChange;
  final void Function(bool isHovered)? onHover;
  final VoidCallback? onLongPress;

  const AppButton({
    super.key,
    this.type = AppButtonType.elevated,
    this.variant = AppButtonVariant.primary,
    this.child,
    this.style,
    this.onPressed,
    this.onFocusChange,
    this.onHover,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {

    final String badUsagesTextButton001 = BadUsagesAppButton.e001.warn();

    // Build

    Widget finalAppButton;

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
    ButtonStyle resolveButtonStyle(
      AppButtonType inType,
      AppButtonVariant inVariant,
      Color inColorMain,
      Color inColorMainContrast
    ) {

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
    Widget resolveButtonType(
      AppButtonType inType,
      ButtonStyle inButtonStyle
    ) {
      switch (inType) {
        // AppButtonType.elevated
        case AppButtonType.elevated:
          return ElevatedButton(
            onPressed: onPressed,
            onFocusChange: onFocusChange,
            onHover: onHover,
            onLongPress: onLongPress,
            style: inButtonStyle,
            child: child,
          );
        // AppButtonType.outlined
        case AppButtonType.outlined:
          return OutlinedButton(
            onPressed: onPressed,
            onFocusChange: onFocusChange,
            onHover: onHover,
            onLongPress: onLongPress,
            style: inButtonStyle,
            child: child,
          );

        // AppButtonType.text
        case AppButtonType.text:
          return TextButton(
            onPressed: onPressed,
            onFocusChange: onFocusChange,
            onHover: onHover,
            onLongPress: onLongPress,
            style: inButtonStyle,
            child: child ?? Text(badUsagesTextButton001),
          );
      }
    }
    // dart format on

    Color rColorMain = resolveColorMain(variant);
    Color rColorMainContrast = resolveColorMainContrast(variant);

    ButtonStyle rButtonStyle = resolveButtonStyle(type, variant, rColorMain, rColorMainContrast);
    finalAppButton = resolveButtonType(type, rButtonStyle);

    return finalAppButton;

  }

}