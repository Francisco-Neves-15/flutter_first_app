import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_button.dart" show BottomSheetButton, BottomSheetButtonPalette;

enum BottomSheetDismissType { close, back }

class BottomSheetContainer extends StatelessWidget {
  final Widget child;

  // --------------- Miscellaneous ---------------
  final String? title;
  final String? description;

  // --------------- Dismiss ---------------
  /// Shows or hides the bottom button
  final bool showDismiss;
  /// Button text/icon (default styles)
  final BottomSheetDismissType dismissType;
  /// Button text/icon (default styles)
  final BottomSheetButtonPalette dismissPalette;
  /// Allows overriding the default behavior.
  final VoidCallback? onDismiss;
  /// Keep the Dismiss element separate from the rest of the content (child).
  final bool showDismissDivider;

  const BottomSheetContainer({
    super.key,
    required this.child,
    // ----- Miscellaneous -----
    this.title,
    this.description,
    // ----- Dismiss -----
    this.showDismiss = true,
    this.dismissType = BottomSheetDismissType.close,
    this.dismissPalette = BottomSheetButtonPalette.text,
    this.onDismiss,
    this.showDismissDivider = true,
  });

  @override
  Widget build(BuildContext context) {

    final String label = switch (dismissType) {
      BottomSheetDismissType.close => "Close",
      BottomSheetDismissType.back => "Back",
    };

    final IconData icon = switch (dismissType) {
      BottomSheetDismissType.close => Symbols.close,
      BottomSheetDismissType.back => Symbols.arrow_top_left_rounded,
    };

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(AppMetrics.base),
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Text(title ?? "Title", style: context.appTheme.textStyles.h1),
              const SizedBox(height: AppMetrics.extraSmall),
              if (description == null) ...[
                const Divider(),
                const SizedBox(height: AppMetrics.extraSmall),
              ]
            ],
            if (description != null) ...[
              Text(description ?? "Description", style: context.appTheme.textStyles.body.copyWith(color: context.appTheme.colors.textSecondary)),
              const SizedBox(height: AppMetrics.extraSmall),
              const Divider(),
              const SizedBox(height: AppMetrics.extraSmall),
            ],
            child,
            if (showDismiss) ...[
              if (showDismissDivider) ...[
                const Divider(),
                const SizedBox(height: AppMetrics.extraSmall),
              ],
              BottomSheetButton(
                palette: dismissPalette,
                icon: icon,
                label: label,
                onPressed: onDismiss ?? () => Navigator.of(context).maybePop(),
              ),
            ],
          ],
        ),
      ),
    );

  }
}
