import 'package:swap_it/models/models.dart';

class GameUserProfile {
  final UserProfile profile;

  final List<GameLevel> levelsPlayed;

  const GameUserProfile({
    required final this.profile,
    required final this.levelsPlayed,
  });
}

class UserProfile {
  final String username;

  const UserProfile({
    required final this.username,
  });
}
