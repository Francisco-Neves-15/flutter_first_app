import "package:flutter/material.dart";

import "package:flutter_first_app/extensions/localization_extension.dart" show L10nBuildContext;
import "package:flutter_first_app/navigation/app_routes.dart" show AppRoutes;
import "package:flutter_first_app/screens/privacy_screen.dart" show PrivacyScreen;
import "package:flutter_first_app/styles/app_metrics.dart" show AppMetrics;
import "package:flutter_first_app/widgets/layout/app_container.dart" show AppContainer;
import "package:flutter_first_app/widgets/layout/app_scaffold.dart" show AppScaffold;

/// Demo screen for `lib/navigation/README_NAVIGATION.md`'s "custom
/// side-menu navigation" section. Has its own sub-route (Privacy) so the
/// side menu's pop-to-existing-or-push behavior has something to collapse.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      appBar: .navigation,
      appBarTitle: l10n.pageSettings.title,
      body: AppContainer(
        autoPadding: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppMetrics.base,
          children: [
            Text(l10n.pageSettings.title),
            // Regular forward push — only the side menu's own items use
            // the pop-to-existing-or-push helper (see AppSideMenu).
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  settings: const RouteSettings(name: AppRoutes.settingsPrivacy),
                  builder: (_) => const PrivacyScreen(),
                ),
              ),
              child: const Text("Privacidade"),
            ),
          ],
        ),
      ),
    );
  }
}
