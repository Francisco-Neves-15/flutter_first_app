import "package:flutter/material.dart";

// Styles
import "package:flutter_first_app/styles/app_theme.dart" show AppTheme;
import "package:flutter_first_app/styles/app_text_styles.dart" show AppTextStyles;

// Theme
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/theme/app_colors_theme.dart" show appLightColors, appDarkColors;

// Localization
import "package:flutter_first_app/localization/generated/app_localizations.dart" show AppLocalizations;
import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;
import "package:flutter_first_app/config/app_config_locales.dart" show AppAvailableLocale, AppAvailableLocaleMapping;

// Navigation
import "package:flutter_first_app/screens/splash_screen.dart" show SplashScreen;

void main() {
  runApp(const MyApp());
}
// - main() → ponto de
// - runApp() → injeta a árvore de widgetentradas na tela
// - tudo no Flutter é um Widget

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(

      listenable: Listenable.merge([
        ThemeController.instance,
        LangController.instance,
      ]),

      builder: (context, _) {
        double screenWidth = MediaQuery.sizeOf(context).width;
        double screenHeight = MediaQuery.sizeOf(context).height;

        return MaterialApp(
          // Theme
          theme: AppTheme.build(appLightColors, screenWidth, screenHeight),
          darkTheme: AppTheme.build(appDarkColors, screenWidth, screenHeight),
          themeMode: ThemeController.instance.themeMode,

          // Localization
          locale: LangController.instance.locale,
          supportedLocales: AppAvailableLocale.values.map((value) => value.locale),
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          // Wrapper global (como um layout provider no React).
          // Precisa ficar DENTRO do MaterialApp — fora dele o Theme ignora tudo.
          builder: (context, child) {
            return (DefaultTextStyle(
              style: AppTextStyles.baseText,
              textAlign: TextAlign.left,
              child: child ?? const SizedBox.shrink(),
            ));
          },

          // Loading persisted preferences + deciding Login vs Home now
          // happens inside SplashScreen instead of blocking main().
          home: const SplashScreen(),
        );
      },
    );
  }
}
