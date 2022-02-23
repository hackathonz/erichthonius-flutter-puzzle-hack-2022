import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'messages/messages_all.dart';

typedef GetLocalizations = AppLocalizations Function(BuildContext context);

const supportedLocales = [Locale('en'), Locale('pt')];

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  final String localeName;

  const AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final name = '${locale.countryCode}'.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
      locale: localeName,
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
