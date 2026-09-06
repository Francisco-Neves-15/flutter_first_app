import "package:flutter/material.dart";
import "package:flutter_first_app/theme/app_colors.dart" show AppColors;

// Testar "botão" de voltar no emulador;

class AppOverlay extends StatelessWidget {

  final OverlayEntry overlayEntry;
  final Widget body;

  final bool? safeArea;

  // --------------- Dismiss ---------------

  // /// Allows overriding the default behavior
  // final Listenable? dismissListenable;

  // /// Allows overriding the default behavior
  // final VoidCallback? onPressedDismiss;

  const AppOverlay({ 
    super.key,
    required this.overlayEntry,
    required this.body,
    this.safeArea = true,
    // this.dismissListenable,
    // this.onPressedDismiss,
  });

  @override
  Widget build(BuildContext context) {

    Widget content = body;
    if (safeArea != null) {
      content = SafeArea(child: content);
    }

    return Stack(
      children: [

        // background
        Positioned.fill(
          child: GestureDetector(
            onTap: () => overlayEntry.remove(),
            child: Container(
              color: AppColors.overlay,
            ),
          ),
        ),

        // content
        Center(child: content),

      ],
    );

  }
}
