import "package:flutter/material.dart";
import "app_colors.dart";

class AppTextStyles {

  static final baseText = TextStyle(
    fontFamily: "Urbanist",
    color: AppColors.text,
  );

  static final textTheme = TextTheme(

    // ----- Display's

    // Normal Use
    displayMedium: baseText.copyWith( fontSize: 32, fontWeight: FontWeight.bold),

    // ----- Titles

    // H1
    titleLarge: baseText.copyWith( fontSize: 24, fontWeight: FontWeight.bold),

    // H2
    titleMedium: baseText.copyWith( fontSize: 20, fontWeight: FontWeight.bold),

    // H3
    titleSmall: baseText.copyWith( fontSize: 16, fontWeight: FontWeight.bold),

    // ----- Body's

    // Normal Use
    bodyMedium: baseText.copyWith( fontSize: 16 ),

    // Occasional
    bodySmall: baseText.copyWith( fontSize: 14 ),

    // ----- Label's

    // Normal Use
    labelMedium: baseText.copyWith( fontSize: 14, fontWeight: FontWeight.bold),

  );
}