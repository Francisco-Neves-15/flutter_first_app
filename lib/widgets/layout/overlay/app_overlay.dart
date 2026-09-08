import "package:flutter/material.dart";
import "package:flutter_first_app/theme/app_colors.dart" show AppColors;

// Testar "botão" de voltar no emulador;

class AppOverlay extends StatelessWidget {

  final OverlayEntry overlayEntry;
  final Widget body;

  final bool? safeArea;

  // --------------- Dismiss ---------------

  final VoidCallback? onDismiss;

  /// If true, calls "onDismiss" when clicking the barrier (transparent background)
  final bool? backgroundTapDismiss;

  const AppOverlay({ 
    super.key,
    required this.overlayEntry,
    required this.onDismiss,
    required this.body,
    this.safeArea = false,
    this.backgroundTapDismiss = true,
  });

  @override
  Widget build(BuildContext context) {

    void dismiss() {
      if (onDismiss == null) {
        debugPrint("$overlayEntry : The barrier was triggered, but no dispensing function was found.");
      } else {
        overlayEntry.remove();
      }
    }

    Widget content = body;
    if (safeArea != null) {
      content = SafeArea(child: content);
    }

    return Stack(
      children: [

        // background
        Positioned.fill(
          child: GestureDetector(
            onTap: (backgroundTapDismiss != null && backgroundTapDismiss == true) ? dismiss : () => {},
            child: Container(
              color: AppColors.overlay,
            ),
          ),
        ),

        // content
        Center(child: body),

      ],
    );

  }
}
