import "package:flutter/material.dart";

class AppTextStyles {

  static final baseText = TextStyle(fontFamilyFallback: ["Roboto"]);

  static final textTheme = TextTheme(

    // ----- Headline's
    headlineLarge: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 57, fontWeight: FontWeight.w900 ),
    headlineMedium: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 45, fontWeight: FontWeight.w900 ),
    headlineSmall: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 36, fontWeight: FontWeight.w900 ),
    // ----- Display's
    displayLarge: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 32, fontWeight: FontWeight.w700 ),
    displayMedium: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 28, fontWeight: FontWeight.w700 ),
    displaySmall: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 24, fontWeight: FontWeight.w700 ),
    // ----- Titles
    titleLarge: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 22, fontWeight: FontWeight.w500 ),
    titleMedium: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 16, fontWeight: FontWeight.w500 ),
    titleSmall: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 14, fontWeight: FontWeight.w500 ),
    // ----- Body's
    bodySmall: baseText.copyWith( fontFamily: "Urbanist", fontSize: 16, fontWeight: FontWeight.w400 ),
    bodyMedium: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.w400 ),
    bodyLarge: baseText.copyWith( fontFamily: "Urbanist", fontSize: 12, fontWeight: FontWeight.w400 ),
    // ----- Label's
    labelLarge: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.w500, ),
    labelMedium: baseText.copyWith( fontFamily: "Urbanist", fontSize: 12, fontWeight: FontWeight.w500 ),
    labelSmall: baseText.copyWith( fontFamily: "Urbanist", fontSize: 11, fontWeight: FontWeight.w500 ),

  );
}