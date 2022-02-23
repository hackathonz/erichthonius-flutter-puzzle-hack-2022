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

  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: 'Play keyword',
      locale: localeName,
    );
  }

  String get ccontinue {
    return Intl.message(
      'Continue',
      name: 'ccontinue',
      desc: 'Continue keyword',
      locale: localeName,
    );
  }

  String get easy {
    return Intl.message(
      'Easy',
      name: 'easy',
      desc: 'Easy keyword',
      locale: localeName,
    );
  }

  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: 'Medium keyword',
      locale: localeName,
    );
  }

  String get hard {
    return Intl.message(
      'Hard',
      name: 'hard',
      desc: 'Hard keyword',
      locale: localeName,
    );
  }

  String get pieces {
    return Intl.message(
      'Pieces',
      name: 'pieces',
      desc: 'Pieces keyword',
      locale: localeName,
    );
  }

  String get shuffle {
    return Intl.message(
      'Shuffle',
      name: 'shuffle',
      desc: 'Shuffle keyword',
      locale: localeName,
    );
  }

  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: 'Retry keyword',
      locale: localeName,
    );
  }

  String get puzzleCompletedDialogTitle {
    return Intl.message(
      'YOU MADE IT 👏',
      name: 'puzzleCompletedDialogTitle',
      desc: 'Title of the dialog that is shown after the puzzle is completed',
      locale: localeName,
    );
  }

  String get nextLevel {
    return Intl.message(
      'Next Level',
      name: 'nextLevel',
      desc: 'Next Level keyword',
      locale: localeName,
    );
  }

  String get exitGame {
    return Intl.message(
      'Exit Game',
      name: 'exitGame',
      desc: 'Exit game keyword',
      locale: localeName,
    );
  }

  String get timeCaps {
    return Intl.message(
      'TIME',
      name: 'timeCaps',
      desc: 'Time keyword in all capital case',
      locale: localeName,
    );
  }

  String welcomeUser(final String username) {
    return Intl.message(
      'Hi $username 👋,',
      name: 'welcomeUser',
      desc: 'Message to welcome user',
      args: [username],
      locale: localeName,
    );
  }

  String get chooseDifficulty {
    return Intl.message(
      'Choose a difficulty',
      name: 'chooseDifficulty',
      desc: 'Message that prompts user to select the games difficulty',
      locale: localeName,
    );
  }

  String get leaderboardTitle {
    return Intl.message(
      'Leaderboard',
      name: 'leaderboardTitle',
      desc: 'Title of leaderboard page',
      locale: localeName,
    );
  }

  String totalPoints(final int points) {
    return Intl.message(
      '$points pts',
      name: 'totalPoints',
      desc: 'Describes how many points an user has',
      args: [points],
      locale: localeName,
    );
  }

  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: 'Today keyword',
      locale: localeName,
    );
  }

  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: 'Week keyword',
      locale: localeName,
    );
  }

  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: 'Month keyword',
      locale: localeName,
    );
  }

  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: 'Title of settings page',
      locale: localeName,
    );
  }

  String get changeProfileDetailsOption {
    return Intl.message(
      'Change profile details',
      name: 'changeProfileDetailsOption',
      desc: 'Settings page option to change user profile details',
      locale: localeName,
    );
  }

  String get notificationsOption {
    return Intl.message(
      'Notifications',
      name: 'notificationsOption',
      desc: 'Settings page option to enable/disable notifications',
      locale: localeName,
    );
  }

  String get soundsOption {
    return Intl.message(
      'Sounds',
      name: 'soundsOption',
      desc: 'Settings page option to enable/disable sounds',
      locale: localeName,
    );
  }

  String get vibrationOption {
    return Intl.message(
      'Vibration',
      name: 'vibrationOption',
      desc: 'Settings page option to enable/disable phone vibration',
      locale: localeName,
    );
  }

  String get profileDetailsTitle {
    return Intl.message(
      'Profile Details',
      name: 'profileDetailsTitle',
      desc: 'Title of user profile details page',
      locale: localeName,
    );
  }

  String puzzleGameLevel(final String level) {
    return Intl.message(
      'Lv. $level',
      name: 'puzzleGameLevel',
      desc:
          'Indicator of the puzzle game level the user is currently or about to play',
      args: [level],
      locale: localeName,
    );
  }

  String puzzleGameTimeLeft(final int secondsLeft) {
    final mins = (secondsLeft / 60).floor();

    final secs = secondsLeft - (mins * 60);

    final useMins = mins > 0 ? 1 : 0;

    return _puzzleGameTimeLeft(useMins, mins, secs);
  }

  String _puzzleGameTimeLeft(
    final int useMins,
    final int mins,
    final int secs,
  ) {
    return Intl.plural(
      useMins,
      zero: '$secs s',
      other: '$mins m $secs s',
      name: '_puzzleGameTimeLeft',
      desc: 'Indicator of the time left to complete the puzzle game',
      args: [useMins, mins, secs],
      locale: localeName,
    );
  }

  String puzzleGameTimeFinalScore(final int score) {
    return Intl.message(
      'Score: $score pts',
      name: 'puzzleGameTimeFinalScore',
      desc: 'Indicator of the score achieved by completing the puzzle game',
      args: [score],
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
