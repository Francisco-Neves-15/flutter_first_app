import 'package:flutter/material.dart';
import 'package:flutter_first_app/localization/i18n.dart' show L10n;

extension L10nBuildContext on BuildContext {
  /// `context.l10n.common.confirm`, `context.l10n.pageHome.welcome`, ...
  L10n get l10n => L10n.of(this);
}
