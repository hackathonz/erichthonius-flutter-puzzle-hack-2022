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

  GameUserProfile copyWith({
    final UserProfile? profile,
  }) {
    return GameUserProfile(
      levelsPlayed: levelsPlayed,
      profile: profile ?? this.profile,
    );
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

  UserProfile copyWith({
    final String? username,
    final Avatar? avatar,
  }) {
    return UserProfile(
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      dateJoined: dateJoined,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'avatar': avatar.toJson(),
      'dateJoined': dateJoined.toUtc().millisecondsSinceEpoch,
    };
  }
}

class Avatar {
  final String data;

  final bool isUrl;

  const Avatar({
    required final this.data,
    required final this.isUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'isUrl': isUrl,
    };
  }
}
