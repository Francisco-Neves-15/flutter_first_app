import "package:flutter/material.dart";

import "app_colors.dart";
import "app_text_styles.dart";

/// Centraliza o ThemeData — equivalente ao ThemeProvider no React.
/// AppColors e AppTextStyles só "funcionam" quando entram aqui.
class AppTheme {

  static ThemeData get light {

    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.primaryContrast,
      secondary: AppColors.primary,
      onSecondary: AppColors.primaryContrast,
      surface: AppColors.background,
      onSurface: AppColors.text,
      inversePrimary: AppColors.primary,
    );

    // Garante que cor e fonte do textTheme não sejam sobrescritas pelo Material 3.
    final textTheme = AppTextStyles.textTheme.apply(
      fontFamily: "Urbanist",
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );

    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primary),
        foregroundColor: WidgetStatePropertyAll(AppColors.primaryContrast),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Urbanist",
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );

    final outlinedButtonTheme = OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.text),
        side: WidgetStatePropertyAll(
          BorderSide(color: AppColors.border, width: 2, strokeAlign: BorderSide.strokeAlignInside),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Urbanist",
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );

    final textButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.text),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: "Urbanist",
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );

    final floatingActionButtonTheme = FloatingActionButtonThemeData(
      iconSize: 32,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    );

    final dividerTheme = DividerThemeData(
      color: AppColors.border,
      thickness: 1.5,
    );

    final iconTheme = IconThemeData(
      size: 24,
    );

    final appBarTheme = AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.primaryContrast,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.primaryContrast,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        )
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: "Urbanist",
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonTheme,      
      outlinedButtonTheme: outlinedButtonTheme,      
      textButtonTheme: textButtonTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      dividerTheme: dividerTheme,
      iconTheme: iconTheme,
      appBarTheme: appBarTheme,
    );
  }
}
