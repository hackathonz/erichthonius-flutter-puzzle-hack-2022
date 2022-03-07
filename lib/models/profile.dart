import 'package:swap_it/models/models.dart';

class GameUserProfile {
  final UserProfile profile;

  final List<GameLevelPlayEntry> levelsPlayed;

  bool get hasPlayedAnyGame => levelsPlayed.isNotEmpty;

  const GameUserProfile({
    required final this.profile,
    required final this.levelsPlayed,
  });

  void registerPlayEntry(final GameLevelPlayEntry playEntry) {
    levelsPlayed.add(playEntry);
  }
}

class UserProfile {
  final String username;

  final Avatar avatar;

  final DateTime dateJoined;

  const UserProfile({
    required final this.username,
    required final this.avatar,
    required final this.dateJoined,
  });
}

class Avatar {
  final String data;

  final bool isUrl;

  const Avatar({
    required final this.data,
    required final this.isUrl,
  });
}
