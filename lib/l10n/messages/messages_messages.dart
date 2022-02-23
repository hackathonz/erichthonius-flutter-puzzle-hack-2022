// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  static m0(useMins, mins, secs) => "${Intl.plural(useMins, zero: '${secs} s', other: '${mins} m ${secs} s')}";

  static m1(level) => "Lv. ${level}";

  static m2(score) => "Score: ${score} pts";

  static m3(points) => "${points} pts";

  static m4(username) => "Hi ${username} 👋,";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "_puzzleGameTimeLeft" : m0,
    "ccontinue" : MessageLookupByLibrary.simpleMessage("Continue"),
    "changeProfileDetailsOption" : MessageLookupByLibrary.simpleMessage("Change profile details"),
    "chooseDifficulty" : MessageLookupByLibrary.simpleMessage("Choose a difficulty"),
    "easy" : MessageLookupByLibrary.simpleMessage("Easy"),
    "exitGame" : MessageLookupByLibrary.simpleMessage("Exit Game"),
    "hard" : MessageLookupByLibrary.simpleMessage("Hard"),
    "leaderboardTitle" : MessageLookupByLibrary.simpleMessage("Leaderboard"),
    "medium" : MessageLookupByLibrary.simpleMessage("Medium"),
    "month" : MessageLookupByLibrary.simpleMessage("Month"),
    "nextLevel" : MessageLookupByLibrary.simpleMessage("Next Level"),
    "notificationsOption" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "pieces" : MessageLookupByLibrary.simpleMessage("Pieces"),
    "play" : MessageLookupByLibrary.simpleMessage("Play"),
    "profileDetailsTitle" : MessageLookupByLibrary.simpleMessage("Profile Details"),
    "puzzleCompletedDialogTitle" : MessageLookupByLibrary.simpleMessage("YOU MADE IT 👏"),
    "puzzleGameLevel" : m1,
    "puzzleGameTimeFinalScore" : m2,
    "retry" : MessageLookupByLibrary.simpleMessage("Retry"),
    "settingsTitle" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shuffle" : MessageLookupByLibrary.simpleMessage("Shuffle"),
    "soundsOption" : MessageLookupByLibrary.simpleMessage("Sounds"),
    "timeCaps" : MessageLookupByLibrary.simpleMessage("TIME"),
    "title" : MessageLookupByLibrary.simpleMessage("Hello World"),
    "today" : MessageLookupByLibrary.simpleMessage("Today"),
    "totalPoints" : m3,
    "vibrationOption" : MessageLookupByLibrary.simpleMessage("Vibration"),
    "week" : MessageLookupByLibrary.simpleMessage("Week"),
    "welcomeUser" : m4
  };
}
