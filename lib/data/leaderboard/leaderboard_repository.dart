import 'dart:math';

import 'package:swap_it/models/models.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardEntry>> retrieveEntries({
    required DateTime from,
    required DateTime to,
  });
}

class RealLeaderboardRepository extends LeaderboardRepository {
  @override
  Future<List<LeaderboardEntry>> retrieveEntries({
    required DateTime from,
    required DateTime to,
  }) {
    throw UnimplementedError();
  }
}

class MockLeaderboardRepository extends LeaderboardRepository {
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
