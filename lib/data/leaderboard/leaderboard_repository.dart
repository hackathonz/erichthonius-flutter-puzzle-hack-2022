import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_it/data/game/game_levels.dart';
import 'package:swap_it/models/models.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardEntry>> retrieveEntries({
    required DateTime from,
    required DateTime to,
  });
}

class RealLeaderboardRepository extends LeaderboardRepository {
  final FirebaseFirestore firestore;

  final String deviceId;

  RealLeaderboardRepository({
    required final this.deviceId,
    required final this.firestore,
  });

  @override
  Future<List<LeaderboardEntry>> retrieveEntries({
    required DateTime from,
    required DateTime to,
  }) async {
    final fromMillisecondsSinceEpoch = from.millisecondsSinceEpoch;
    final toMillisecondsSinceEpoch = to.millisecondsSinceEpoch;

    final games = await firestore
        .collection('games')
        .where(
          'playDateTime',
          isGreaterThanOrEqualTo: fromMillisecondsSinceEpoch,
          isLessThanOrEqualTo: toMillisecondsSinceEpoch,
        )
        .get();

    final gameUserProfiles = games.docs.map(
      (x) => Game.fromJson(
        x.data(),
        defaultGameLevels,
      ).gameUserProfile,
    );

    final pointsByUserProfile = gameUserProfiles
        .map(
          (x) => MapEntry(
            x.levelsPlayed
                .where(
                  (x) =>
                      x.playDateTime.isAfter(from) &&
                      x.playDateTime.isBefore(to),
                )
                .fold<int>(0, (p, c) => p + c.pointsObtained),
            x,
          ),
        )
        .toList();

    pointsByUserProfile.sort((x, y) => -x.key.compareTo(y.key));

    return [
      for (var i = 0; i < pointsByUserProfile.length; i++)
        LeaderboardEntry(
          points: pointsByUserProfile[i].key,
          rankingPosition: i + 1,
          userProfile: pointsByUserProfile[i].value.profile,
        ),
    ];
  }
}

class FakeLeaderboardRepository extends LeaderboardRepository {
  @override
  Future<List<LeaderboardEntry>> retrieveEntries({
    required DateTime from,
    required DateTime to,
  }) {
    return Future.value(
      List.generate(
        Random().nextInt(10),
        (index) {
          return LeaderboardEntry(
            points: Random().nextInt(500) * (index + 1),
            rankingPosition: index + 1,
            userProfile: UserProfile(
              username: 'Swapper00$index',
              avatar: Avatar(
                data: '😎 $index',
                isUrl: false,
              ),
              dateJoined: DateTime.now(),
            ),
          );
        },
      ),
    );
  }
}
