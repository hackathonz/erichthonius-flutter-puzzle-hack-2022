export 'avatar/avatar.dart';
export 'game/game.dart';
export 'leaderboard/leaderboard_repository.dart';
export 'profile/profile.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> initFirebase() {
  return Firebase.initializeApp();
}
