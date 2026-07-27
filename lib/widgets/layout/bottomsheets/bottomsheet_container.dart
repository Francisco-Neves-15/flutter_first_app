import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_button.dart" show BottomSheetButton, BottomSheetButtonPalette;

enum BottomSheetDismissType { close, back }

class BottomSheetContainer extends StatelessWidget {
  final Widget child;

  // --------------- Header ---------------
  final String? title;
  final String? description;
  /// Keep the Header element separate from the rest of the content (child)
  final bool showHeaderDivider;

  // --------------- Dismiss ---------------
  /// Shows or hides the bottom button
  final bool showDismiss;
  /// Button text/icon (default styles)
  final BottomSheetDismissType dismissType;
  /// Button text/icon (default styles)
  final BottomSheetButtonPalette dismissPalette;
  /// Allows overriding the default behavior
  final VoidCallback? onDismiss;
  /// Keep the Dismiss element separate from the rest of the content (child)
  final bool showDismissDivider;

  const BottomSheetContainer({
    super.key,
    required this.child,
    // ----- Header -----
    this.title,
    this.description,
    this.showHeaderDivider = false,
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
      BottomSheetDismissType.back => Symbols.reply_rounded,
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
              if (showHeaderDivider && description == null) ...[
                const Divider()
              ]
            ],
            if (description != null) ...[
              Text(description ?? "Description", style: context.appTheme.textStyles.body.copyWith(color: context.appTheme.colors.textSecondary)),
              const SizedBox(height: AppMetrics.extraSmall),
              if (showHeaderDivider && description == null) ...[
                const Divider()
              ]
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
            ]
          ],
        ),
      ),
    );

  }
}
