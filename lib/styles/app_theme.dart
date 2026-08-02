import "package:flutter/material.dart";
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

import "package:flutter_first_app/theme/app_available_themes.dart" show AppAvailableThemeMode;
import "package:flutter_first_app/styles/app_colors_theme.dart" show AppThemeColors;
import "package:material_symbols_icons/symbols.dart" show Symbols;

import "app_text_styles.dart" show AppTextStyles;

class AppTheme {
  
  static ThemeData build(AppThemeColors colors) {

    ColorScheme colorScheme;
    if (colors.themeMode == AppAvailableThemeMode.dark) {
      colorScheme = ColorScheme.dark(
        primary: colors.primary,
        onPrimary: colors.primaryContrast,
        inversePrimary: colors.primary,
        secondary: colors.primary,
        onSecondary: colors.primaryContrast,
        surface: colors.background,
        onSurface: colors.text,
        error: colors.danger,
        onError: colors.dangerContrast,
        shadow: colors.shadow,
      );
    } else {
      colorScheme = ColorScheme.light(
        primary: colors.primary,
        onPrimary: colors.primaryContrast,
        inversePrimary: colors.primary,
        secondary: colors.primary,
        onSecondary: colors.primaryContrast,
        surface: colors.background,
        onSurface: colors.text,
        error: colors.danger,
        onError: colors.dangerContrast,
        shadow: colors.shadow,
      );
    }

    // Garante que cor e fonte do textTheme não sejam sobrescritas pelo Material 3.
    final textTheme = AppTextStyles.textTheme.apply(
      fontFamily: "Urbanist",
      bodyColor: colors.text,
      displayColor: colors.text,
    );

    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colors.primary),
        foregroundColor: WidgetStatePropertyAll(colors.primaryContrast),

        textStyle: WidgetStatePropertyAll(AppTextStyles.appTextStyle.buttonText),
        // Icon
        iconColor: WidgetStatePropertyAll(colors.text),
        iconSize: WidgetStatePropertyAll(24),
        iconAlignment: IconAlignment.start,

        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ))
      ),
    );

    final outlinedButtonTheme = OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(colors.text),
        side: WidgetStatePropertyAll(
          BorderSide(color: colors.border, width: 1, strokeAlign: BorderSide.strokeAlignInside),
        ),
        textStyle: WidgetStatePropertyAll(AppTextStyles.appTextStyle.buttonText),
        // Icon
        iconColor: WidgetStatePropertyAll(colors.text),
        iconSize: WidgetStatePropertyAll(24),
        iconAlignment: IconAlignment.start,

        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ))
      ),
    );

    final textButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(colors.text),
        textStyle: WidgetStatePropertyAll(AppTextStyles.appTextStyle.buttonText),

        // Icon
        iconColor: WidgetStatePropertyAll(colors.text),
        iconSize: WidgetStatePropertyAll(24),
        iconAlignment: IconAlignment.start,

        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ))
      ),
    );

    final floatingActionButtonTheme = FloatingActionButtonThemeData(
      elevation: 0,
      iconSize: 32,
      backgroundColor: colors.primary,
      foregroundColor: colors.primaryContrast,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),

    );

    final iconButtonTheme = IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(colors.text),
        iconSize: WidgetStatePropertyAll(24),
      )
    );

    final segmentedButtonTheme = SegmentedButtonThemeData(
      selectedIcon: Icon(Symbols.check_rounded, size: 20, fill: 1, color: colors.primaryContrast),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primaryAlpha;
          }
          // return colors.background;
          return Colors.transparent;
        }),
        side: WidgetStatePropertyAll(
          BorderSide(color: colors.base, width: 1, strokeAlign: BorderSide.strokeAlignInside),
        ),
      ),
    );

    final dividerTheme = DividerThemeData(
      color: colors.border,
      thickness: 1.5,
    );

    final iconTheme = IconThemeData(
      size: 24,
    );

    final appBarTheme = AppBarTheme(
      // backgroundColor: colors.primary,
      backgroundColor: colors.background,
      foregroundColor: colors.text,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.appTextStyle.h1.copyWith(
        color: colors.text,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        )
      ),
      iconTheme: IconThemeData(
        color: colors.text,
      ),
    );

    final navigationBarTheme = NavigationBarThemeData(
      elevation: 0,
      labelPadding: .all(0),
      labelBehavior: .alwaysShow,
      backgroundColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: colors.primary,
              fontSize: 12,
              fontStyle: .normal,
              fontWeight: .w500,
              fontFamily: "Urbanist"
            );
          }
          return TextStyle(
            color: colors.text,
              fontSize: 12,
              fontStyle: .normal,
              fontWeight: .w500,
              fontFamily: "Urbanist"
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
        (states) {
          return IconThemeData(
            color: colors.primary,
            size: 32
          );
        },
      ),
    );

    final badgeTheme = BadgeThemeData(
      backgroundColor: colors.primary,
      textColor: colors.primaryContrast,
      padding: .all(AppMetrics.min),
      textStyle: TextStyle(
        color: colors.primaryContrast,
        fontSize: 12,
        fontStyle: .normal,
        fontWeight: .w500,
        fontFamily: "Urbanist"
      )
    );

    final tabBarTheme = TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorAnimation: .elastic,
      indicatorColor: colors.primary,

      dividerColor: Colors.transparent,
      dividerHeight: 2,
      
      tabAlignment: TabAlignment.fill,
          
      labelPadding: EdgeInsets.symmetric(
        horizontal: AppMetrics.base,
        vertical: AppMetrics.extraSmall,
      ),

      labelColor: colors.primary,
      unselectedLabelColor: colors.text,

      labelStyle: TextStyle(
        color: colors.text,
        fontSize: 14,
        fontStyle: .normal,
        fontWeight: .w500,
        fontFamily: "Urbanist"
      ),

    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonTheme,      
      outlinedButtonTheme: outlinedButtonTheme,
      textButtonTheme: textButtonTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      iconButtonTheme: iconButtonTheme,
      segmentedButtonTheme: segmentedButtonTheme,
      dividerTheme: dividerTheme,
      iconTheme: iconTheme,
      appBarTheme: appBarTheme,
      shadowColor: colorScheme.shadow,
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        dragHandleColor: colors.neutral,
        dragHandleSize: Size(128, 4),
      ),
      navigationBarTheme: navigationBarTheme,
      badgeTheme: badgeTheme,
      tabBarTheme: tabBarTheme
    );
  }
}
