import "package:flutter/material.dart";

// Controllers
import "package:flutter_first_app/controllers/theme_controller.dart" show ThemeController;
import "package:flutter_first_app/controllers/lang_controller.dart" show LangController;
import "package:flutter_first_app/controllers/auth_controller.dart" show AuthController;

// Screens
import "package:flutter_first_app/screens/home_screen.dart" show HomePage;
import "package:flutter_first_app/screens/login_screen.dart" show LoginScreen;

// Widgets
import "package:flutter_first_app/widgets/ui/app_logo.dart" show AppLogo;

/// First screen the app shows. Loads persisted preferences (theme/language)
/// while it's on screen, then decides where to go next based on auth state.
/// See `lib/navigation/README_NAVIGATION.md`.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // This used to run in `main()`, before `runApp`. It moved here once
    // this screen existed, so the loading time is actually spent with
    // something visible on screen instead of before the first frame.
    await ThemeController.instance.loadPersistedPreference();
    await LangController.instance.loadPersistedPreference();

    if (!mounted) return;

    // forced loading, only for debug
    // await Future.delayed(const Duration(seconds: 10));

    // pushReplacement: swaps Splash for Login/Home on the navigation stack.
    // Splash is gone from history — there's no way back to it, which is the
    // point (nobody should ever see it again once decided where to go).
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AuthController.instance.isLoggedIn
            ? const HomePage(title: "WatchList")
            : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child:
      Column(
        spacing: 16,
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          AppLogo(width: 128, height: 128),
          CircularProgressIndicator(),
          LinearProgressIndicator(),
          RefreshProgressIndicator(),
        ],
      )
    ));
  }
}
