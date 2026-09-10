import "package:flutter/material.dart";

import "package:flutter_first_app/widgets/layout/app_container.dart" show AppContainer;
import "package:flutter_first_app/widgets/layout/app_scaffold.dart" show AppScaffold;

/// Demo sub-route of Settings — see
/// `lib/navigation/README_NAVIGATION.md`'s "custom side-menu navigation"
/// section. Opening the side menu here and tapping "Configurações" should
/// pop back to Settings instead of stacking a duplicate.
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: .navigation,
      appBarTitle: "Privacidade",
      body: AppContainer(
        autoPadding: true,
        content: Text("Tela de Privacidade (sub-rota de Configurações)."),
      ),
    );
  }
}
