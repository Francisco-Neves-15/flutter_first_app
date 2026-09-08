import "package:flutter/material.dart";

// Controllers
import "package:flutter_first_app/controllers/auth_controller.dart" show AuthController;

// Extensions
import "package:flutter_first_app/extensions/theme_extension.dart" show AppThemeExtensionContext;

// Screens
import "package:flutter_first_app/screens/home_screen.dart" show HomePage;

// Styles
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;

/// The app's "index" while logged out. There's no real auth backend here —
/// the button just flips `AuthController` and moves on. See
/// `lib/navigation/README_NAVIGATION.md`.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _login(BuildContext context) {
    AuthController.instance.login();

    // pushReplacement: swaps Login for Home on the stack. Login is gone
    // from history — the hardware/gesture back button on Home won't return
    // to it, same as Splash disappearing after this screen took over.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage(title: "WatchList")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppMetrics.base),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppMetrics.base,
            children: [
              Text("Login", style: context.appTheme.textStyles.h1),
              Text(
                "Navigation demo — no real backend, just AuthController.login().",
                textAlign: TextAlign.center,
                style: context.appTheme.textStyles.body.copyWith(
                  color: context.appTheme.colors.textSecondary,
                ),
              ),
              ElevatedButton(
                onPressed: () => _login(context),
                child: const Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
