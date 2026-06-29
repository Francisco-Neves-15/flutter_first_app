import "package:flutter/material.dart";

class AppTextStyles {

  static final baseText = TextStyle();

  static final textTheme = TextTheme(

    // ----- Display's

    // Normal Use
    displayLarge: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 36, fontWeight: FontWeight.bold ),
    displayMedium: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 32, fontWeight: FontWeight.bold ),
    displaySmall: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 28, fontWeight: FontWeight.bold ),

    // ----- Titles

    // H1
    titleLarge: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 24, fontWeight: FontWeight.bold ),

    // H2
    titleMedium: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 20, fontWeight: FontWeight.bold ),

    // H3
    titleSmall: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 16, fontWeight: FontWeight.bold ),

    // ----- Body's

    // Normal Use
    bodyMedium: baseText.copyWith( fontFamily: "Urbanist", fontSize: 16  ),

    // Occasional
    bodySmall: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14  ),
    bodyLarge: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14  ),

    // ----- Label's

    // Normal Use
    labelLarge: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.bold ),
    labelMedium: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.bold ),
    labelSmall: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.bold ),

  );
}