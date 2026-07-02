// ! ============================================== !
// If you edit this file while the app is running, 
// hot reload will not be sufficient to apply the changes.
// You will need to stop the app and run it again.
// ! ============================================== !

import "package:flutter/material.dart";
import "package:flutter_first_app/fallbacks/styles/font_family_fallback.dart" show resolveFontFamilyFallback;

@immutable
class AppTextStyle {
  final TextStyle display;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle micro;
  final TextStyle label;
  final TextStyle buttonText;
  final TextStyle buttonSmallText;

  const AppTextStyle({
    required this.display,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.body,
    required this.caption,
    required this.micro,
    required this.label,
    required this.buttonText,
    required this.buttonSmallText,
  });
}

class AppTextStyles {

  static final baseText = TextStyle(
    fontFamilyFallback: resolveFontFamilyFallback(useRuntime: false),
  );

  static final appTextStyle = AppTextStyle(
    display: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 32, fontWeight: FontWeight.w700 ),
    h1: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 24, fontWeight: FontWeight.w700 ),
    h2: baseText.copyWith( fontFamily: "DynaPuff", fontSize: 20, fontWeight: FontWeight.w700 ),
    h3: baseText.copyWith( fontFamily: "Urbanist", fontSize: 16, fontWeight: FontWeight.w700 ),
    body: baseText.copyWith( fontFamily: "Urbanist", fontSize: 16, fontWeight: FontWeight.w400 ),
    caption: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.w400 ),
    micro: baseText.copyWith( fontFamily: "Urbanist", fontSize: 12, fontWeight: FontWeight.w400 ),
    label: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.w500 ),
    buttonText: baseText.copyWith( fontFamily: "Urbanist", fontSize: 16, fontWeight: FontWeight.w700 ),
    buttonSmallText: baseText.copyWith( fontFamily: "Urbanist", fontSize: 14, fontWeight: FontWeight.w700 ),
  );

  // Default from Material
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