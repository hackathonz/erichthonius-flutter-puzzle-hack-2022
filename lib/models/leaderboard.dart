import 'package:swap_it/models/models.dart';

class LeaderboardEntry {
  final int rankingPosition;

  final UserProfile userProfile;

  final int points;

  const LeaderboardEntry({
    required final this.points,
    required final this.rankingPosition,
    required final this.userProfile,
  });
}

class Leaderboard {
  final List<LeaderboardEntry> topRanking;

  final List<LeaderboardEntry> entries;

  const Leaderboard({
    required final this.entries,
    required final this.topRanking,
  });
}

enum LeaderboardRankingPeriod {
  today,
  weekly,
  monthly,
}
