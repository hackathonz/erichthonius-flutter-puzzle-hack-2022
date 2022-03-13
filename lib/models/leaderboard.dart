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
