import "package:flutter/material.dart";
import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
// import "package:flutter_first_app/docs/widgets/layout/bottomsheet/bad_usages.dart" show BadUsagesBottomsheets;
import "package:material_symbols_icons/symbols.dart" show Symbols;
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/bottomsheets/bottom_sheet_button.dart" show BottomSheetButton, ActionSheetButtonPalette;

enum BottomSheetHeadInfoLayout { small, large }

enum BottomSheetDismissLocation { actions, footer }
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

  /// Keep the Header element separate from the rest of the content (child)
  final bool showDividerHeader;

  // --------------- Head Info ---------------

  /// Change title/description layout
  final BottomSheetHeadInfoLayout headInfoLayout;

  final String? title;
  final String? description;

  // --------------- Footer ---------------

  /// Keep the Footer element separate from the rest of the content (child)
  final bool showDividerFooter;

  // --------------- Dismiss ---------------

  final Listenable? dismissListenable;

  /// Shows or hides the bottom button
  final bool showDismiss;

  /// Dismiss Button Location (In the header or at the bottom)
  final BottomSheetDismissLocation dismissLocation;

  /// Button text/icon pallete (based on ActionSheetButtonPalette)
  final ActionSheetButtonPalette dismissPalette;

  /// Change text/icon type (close or back label)
  final BottomSheetDismissLayout dismissLayout;

  /// Allows overriding the default behavior
  final VoidCallback? onPressedDismiss;

  // --------------- Actions ---------------

  /// List of actions visible at the top of the bottom sheet | Default used: IconButton(icon: Icon(icon_name, size: 24, color: context.appTheme.colors.text))
  final List<Widget>? actions;

  // Continue
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
    this.showDividerHeader = true,
    // ----- Head Info -----
    this.headInfoLayout = BottomSheetHeadInfoLayout.small,
    this.title,
    this.description,
    // ----- Footer -----
    this.showDividerFooter = false,
    // ----- Dismiss -----
    this.dismissListenable,
    this.showDismiss = true,
    this.dismissLocation = BottomSheetDismissLocation.actions,
    this.dismissPalette = ActionSheetButtonPalette.text,
    this.dismissLayout = BottomSheetDismissLayout.close,
    this.onPressedDismiss,
    // ----- Actions -----
    this.actions
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
    if (widget.onPressedDismiss != null) {
      widget.onPressedDismiss!();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {

    final l10n = context.l10n;
    
    // Continue

    // Values

    const double smallGap = AppMetrics.min;
    const double mainGap = AppMetrics.extraSmall;
    const double largeGap = AppMetrics.small;

    const Widget widgetSmallGap = SizedBox(height: smallGap);
    const Widget widgetMainGap = SizedBox(height: mainGap);
    const Widget widgetLargeGap = SizedBox(height: largeGap);

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

    final Widget widgetDragHandle = Container(
      decoration: BoxDecoration(
        color: context.appTheme.colors.neutral,
        borderRadius: BorderRadius.circular(containerFinalHeight / 2),
      ),
      width: containerFinalWidth,
      height: containerFinalHeight,
    );

    // Dismiss

    final List<Widget> dismissButton = [];

    if (widget.showDismiss) {

      final String dismissLabel = switch (widget.dismissLayout) {
        BottomSheetDismissLayout.close => l10n.common.close,
        BottomSheetDismissLayout.back => l10n.common.back,
      };

      final IconData dismissIcon = switch (widget.dismissLayout) {
        BottomSheetDismissLayout.close => Symbols.close,
        BottomSheetDismissLayout.back => Symbols.reply_rounded,
      };

      dismissButton.addAll(
        switch (widget.dismissLocation) {
          BottomSheetDismissLocation.actions => [
            IconButton(
              tooltip: dismissLabel,
              icon: Icon(dismissIcon, size: 24, color: context.appTheme.colors.text),
              onPressed: widget.onPressedDismiss ?? () => Navigator.of(context).maybePop(),
            )
          ],
          BottomSheetDismissLocation.footer => [
            widgetMainGap,
            BottomSheetButton(
              palette: widget.dismissPalette,
              label: dismissLabel,
              icon: dismissIcon,
              onPressed: widget.onPressedDismiss ?? () => Navigator.of(context).maybePop(),
            ),
          ]
        }
      );
    }

    // Head Info

    final List<Widget> widgetHeadInfo = switch (widget.headInfoLayout) {
      BottomSheetHeadInfoLayout.small => [
        if (widget.title != null || widget.description != null) ...[
          Column( 
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              if (widget.title != null) ...[
                Text(widget.title!, style: context.appTheme.textStyles.h2),
                if (widget.description != null) ...[widgetSmallGap]
              ],
              if (widget.description != null) ...[
                Text(
                  widget.description!,
                  style: context.appTheme.textStyles.label.copyWith(color: context.appTheme.colors.textSecondary),
                ),
              ]
            ],
          )
        ] else ...[]
      ],
      BottomSheetHeadInfoLayout.large => [
        if (widget.title != null || widget.description != null) ...[
          Column( 
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              if (widget.title != null) ...[
                Text(widget.title!, style: context.appTheme.textStyles.h1),
                if (widget.description != null) ...[widgetMainGap]
              ],
              if (widget.description != null) ...[
                Text(
                  widget.description!,
                  style: context.appTheme.textStyles.body.copyWith(color: context.appTheme.colors.textSecondary),
                ),
              ]
            ],
          )
        ] else ...[]
      ]
    };

    // Actions

    List<Widget> widgetActions = widget.actions ?? [];

    if (widget.showDismiss && widget.dismissLocation == BottomSheetDismissLocation.actions) {
      widgetActions = [
        ...widgetActions,
        ...dismissButton,
      ];
    }

    // Header

    final List<Widget> widgetHeader = switch (widget.headInfoLayout) {
      BottomSheetHeadInfoLayout.small => [
        Row(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: mainGap,
          children: [
            ...widgetHeadInfo,
            Spacer(),
            ...widgetActions,
          ],
        )
      ],
      BottomSheetHeadInfoLayout.large => [
        Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          spacing: mainGap,
          children: [
            ...widgetHeadInfo,
            Row(
              mainAxisAlignment: .end,
              crossAxisAlignment: .center,
              children: [
                ...widgetActions
              ],
            )
          ],
        )
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
            color: context.appTheme.colors.backgroundSecondary,
            borderRadius: containerBorderRadius,
          ),
          child: Column(
            mainAxisSize: .min,
            children: [
              if (widget.showDragHandle) ...[
                widgetSmallGap,
                widgetDragHandle, 
                widgetSmallGap,
                widgetLargeGap
              ],
              ...widgetHeader,
              if (widget.showDividerHeader) ...[
                widgetMainGap,
                Divider(),
                widgetMainGap
              ] else widgetLargeGap,
              widget.child,
              if (widget.showDividerFooter) Divider(),
              if (widget.dismissLocation == .footer) ...dismissButton
            ],
          ),
        ),
      ),
    );
  }
}
