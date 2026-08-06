// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String welcomeWithName(String firstName, String lastName) {
    return 'Welcome $firstName $lastName!';
  }

  @override
  String newMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new messages',
      one: 'One new message',
      zero: 'No new messages',
    );
    return '$_temp0';
  }

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonClose => 'Close';

  @override
  String get commonSave => 'Save';

  @override
  String get commonTypeHere => 'Type here';

  @override
  String get pageHomeTitle => 'Home';

  @override
  String get pageHomeWelcome => 'Welcome to the app!';

  @override
  String get pageHomeButtonClick => 'Click here';

  @override
  String get pageSettingsTitle => 'Settings';

  @override
  String get pageSettingsLanguageLabel => 'Language';

  @override
  String get pageSettingsThemeLabel => 'Theme';
}
