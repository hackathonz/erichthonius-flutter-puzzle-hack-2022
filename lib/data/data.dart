import 'package:firebase_core/firebase_core.dart';

export 'avatar/avatar.dart';
export 'game/game.dart';
export 'leaderboard/leaderboard_repository.dart';
export 'profile/profile.dart';
export 'settings/settings.dart';

Future<void> initFirebase() {
  return Firebase.initializeApp();
}
