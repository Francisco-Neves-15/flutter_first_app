// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get hello => 'Olá';

  @override
  String welcomeWithName(String firstName, String lastName) {
    return 'Bem-vindo $firstName $lastName!';
  }

  @override
  String newMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensagens novas',
      one: 'Uma mensagem nova',
      zero: 'Nenhuma mensagem nova',
    );
    return '$_temp0';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonTypeHere => 'Digite aqui';

  @override
  String get pageHomeTitle => 'Início';

  @override
  String get pageHomeWelcome => 'Bem-vindo ao app!';

  @override
  String get pageHomeButtonClick => 'Clique aqui';

  @override
  String get pageSettingsTitle => 'Definições';

  @override
  String get pageSettingsLanguageLabel => 'Idioma';
}
