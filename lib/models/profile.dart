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

  static GameUserProfile fromJson(
    Map<String, dynamic> json,
    List<GameLevel> levels,
  ) {
    return GameUserProfile(
      profile: UserProfile.fromJson(
        json['profile'],
      ),
      levelsPlayed: List.castFrom<dynamic, Map<String, dynamic>>(
        json['levelsPlayed'],
      ).map((x) => GameLevelPlayEntry.fromJson(x, levels)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile.toJson(),
      'levelsPlayed': levelsPlayed.map((x) => x.toJson()).toList(),
    };
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

  static UserProfile fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfile(
      avatar: Avatar.fromJson(
        json['avatar'],
      ),
      dateJoined: DateTime.fromMillisecondsSinceEpoch(
        json['dateJoined'],
      ),
      username: json['username'],
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

  static Avatar fromJson(
    Map<String, dynamic> json,
  ) {
    return Avatar(
      data: json['data'],
      isUrl: json['isUrl'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'isUrl': isUrl,
    };
  }
}
