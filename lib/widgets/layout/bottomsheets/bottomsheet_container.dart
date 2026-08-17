import "package:flutter/material.dart";
import "package:flutter_first_app/docs/widgets/layout/bottomsheet/bad_usages.dart" show BadUsagesBottomsheets;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottomsheet_button.dart" show BottomSheetButton, ActionSheetButtonPalette;

enum BottomSheetHeaderLayout { small, large }

enum BottomSheetDismissLocation { header, bottom }
enum BottomSheetDismissLayout { close, back }

class BottomSheetContainer extends StatefulWidget {
  final Widget child;

  // ----- Others -----
  /// In test
  final bool floatingContainer;

  // ----- Drag Handle -----
  final bool showDragHandle;
  final Color? dragHandleColor;
  final Size? dragHandleSize;

  // --------------- Header ---------------

  final bool showHeader;
  /// Keep the Header element separate from the rest of the content (child)
  final bool showDividerHeader;
  /// Change title/description layout
  final BottomSheetHeaderLayout headerLayout;

  final String? title;
  final String? description;

  // --------------- Dismiss ---------------
  final Listenable? dismissListenable;

  /// Shows or hides the bottom button
  final bool showDismissButton;
  /// Dismiss Button Location (In the header or at the bottom)
  final BottomSheetDismissLocation dismissLocation;
  /// (only if dismissLocation == bottom) Keep the dismiss element separate from the rest of the content (child)
  final bool showDividerDismissButtonBottom;

  /// Button text/icon pallete (based on ActionSheetButtonPalette)
  final ActionSheetButtonPalette dismissPalette;
  /// Change text/icon type (close or back label)
  final BottomSheetDismissLayout dismissLayout;

  /// Allows overriding the default behavior
  final VoidCallback? onDismiss;

  const BottomSheetContainer({
    super.key,
    required this.child,
    // ----- Others -----
    this.floatingContainer = false,
    // ----- Drag Handle -----
    this.showDragHandle = true,
    this.dragHandleColor,
    this.dragHandleSize,
    // ----- Header -----
    this.showHeader = true,
    this.showDividerHeader = true,
    this.headerLayout = BottomSheetHeaderLayout.small,
    this.title,
    this.description,
    // ----- Dismiss -----
    this.dismissListenable,
    this.showDismissButton = false,
    this.dismissLocation = BottomSheetDismissLocation.header,
    this.showDividerDismissButtonBottom = false,
    this.dismissPalette = ActionSheetButtonPalette.text,
    this.dismissLayout = BottomSheetDismissLayout.close,
    this.onDismiss
  });

  @override
  State<BottomSheetContainer> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {

  @override
  void initState() {
    super.initState();
    widget.dismissListenable?.addListener(_handleDismissTrigger);
  }

  @override
  void didUpdateWidget(covariant BottomSheetContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dismissListenable != widget.dismissListenable) {
      oldWidget.dismissListenable?.removeListener(_handleDismissTrigger);
      widget.dismissListenable?.addListener(_handleDismissTrigger);
    }
  }

  @override
  void dispose() {
    widget.dismissListenable?.removeListener(_handleDismissTrigger);
    super.dispose();
  }

  void _handleDismissTrigger() {
    if (!mounted) return;
    if (widget.onDismiss != null) {
      widget.onDismiss!();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {

    // Assert's

    assert(
      !(widget.showDismissButton == true && widget.dismissLocation == BottomSheetDismissLocation.header),
      BadUsagesBottomsheets.e001.warn(),
    );
    
    // Continue

    // Floating Container

    final double containerFinalWidth = widget.dragHandleSize?.width ?? 64;
    final double containerFinalHeight = widget.dragHandleSize?.height ?? 4;
    final double containerBorderRadiusValue = widget.floatingContainer ? 16 : 32;

    final BorderRadiusGeometry containerBorderRadius = BorderRadius.only(
      topRight: Radius.circular(containerBorderRadiusValue),
      topLeft: Radius.circular(containerBorderRadiusValue),
      bottomLeft: widget.floatingContainer ? Radius.circular(containerBorderRadiusValue) : Radius.zero,
      bottomRight: widget.floatingContainer ? Radius.circular(containerBorderRadiusValue) : Radius.zero,
    );

    // Layout

    // DragHandle

    final List<Widget> widgetDragHandle = [
      const SizedBox(height: AppMetrics.small),
      Container(
        decoration: BoxDecoration(
          color: context.appTheme.colors.neutral,
          borderRadius: BorderRadius.circular(containerFinalHeight / 2),
        ),
        width: containerFinalWidth,
        height: containerFinalHeight,
      ),
      const SizedBox(height: AppMetrics.base),
    ];

    // DismissButton

    final String dismissLabel = switch (widget.dismissLayout) {
      BottomSheetDismissLayout.close => "Close",
      BottomSheetDismissLayout.back => "Back",
    };

    final IconData dismissIcon = switch (widget.dismissLayout) {
      BottomSheetDismissLayout.close => Symbols.close,
      BottomSheetDismissLayout.back => Symbols.reply_rounded,
    };

    final List<Widget> dismissButton = switch (widget.dismissLocation) {
      BottomSheetDismissLocation.bottom => [
        const SizedBox(height: AppMetrics.small),
        if (widget.showDividerDismissButtonBottom) ...[
          const Divider(),
          const SizedBox(height: AppMetrics.extraSmall),
        ],
        BottomSheetButton(
          palette: widget.dismissPalette,
          label: dismissLabel,
          icon: dismissIcon,
          onPressed: widget.onDismiss ?? () => Navigator.of(context).maybePop(),
        ),
      ],
      BottomSheetDismissLocation.header => [
        IconButton(
          tooltip: dismissLabel,
          icon: Icon(dismissIcon, size: 16, color: context.appTheme.colors.text),
          onPressed: widget.onDismiss ?? () => Navigator.of(context).maybePop(),
        )
      ]
    };

    // Header

    final List<Widget> widgetHeader = switch (widget.headerLayout) {
      BottomSheetHeaderLayout.small => [
        Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  children: [
                    if (widget.title != null) ...[
                      Text(widget.title!, style: context.appTheme.textStyles.h3)
                    ],
                    if (widget.description != null) ...[
                      Text(
                        widget.description!,
                        style: context.appTheme.textStyles.label.copyWith(
                          color: context.appTheme.colors.textSecondary,
                        ),
                      ),
                    ]
                  ],
                ),
                Spacer(),
                if (widget.showDismissButton) ...dismissButton
              ],
            ),
            if (widget.showDividerHeader) ...[
              const SizedBox(height: AppMetrics.small),
              const Divider(),
              const SizedBox(height: AppMetrics.small),
            ] else ...[
              const SizedBox(height: AppMetrics.small)
            ]
          ],
        )
      ],
      BottomSheetHeaderLayout.large => [
        // Title
        if (widget.title != null) ...[
          Text(widget.title!, style: context.appTheme.textStyles.h1),
          const SizedBox(height: AppMetrics.extraSmall),
          if (widget.showDividerHeader && widget.description == null) ...[
            const Divider(),
          ],
        ],
        // Description
        if (widget.description != null) ...[
          Text(
            widget.description!,
            style: context.appTheme.textStyles.body.copyWith(
              color: context.appTheme.colors.textSecondary,
            ),
          ),
          if (widget.showDividerHeader) ...[
            const SizedBox(height: AppMetrics.small),
            const Divider(),
            const SizedBox(height: AppMetrics.small),
          ] else ...[
            const SizedBox(height: AppMetrics.small)
          ]
        ]
      ]
    };

    // Return
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.transparent,
        padding: widget.floatingContainer ? const EdgeInsets.all(AppMetrics.base) : EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(AppMetrics.base),
          decoration: BoxDecoration(
            color: context.appTheme.colors.backgroundSurface,
            borderRadius: containerBorderRadius,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showDragHandle) ...widgetDragHandle,
              if (widget.showHeader) ...widgetHeader,
              widget.child,
              if (widget.showHeader) ...widgetHeader,
              if (widget.showDismissButton) ...dismissButton
            ],
          ),
        ),
      ),
    );
  }
}
