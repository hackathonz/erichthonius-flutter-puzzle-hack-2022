part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardEvent {}

class LoadLeaderboardStarted extends LeaderboardEvent {
  final LeaderboardRankingPeriod period;

  LoadLeaderboardStarted({
    required final this.period,
  });
}

class RetrieveLeaderboardsStarted extends LeaderboardEvent {}

class RefreshLeaderboardsStarted extends RetrieveLeaderboardsStarted {}
