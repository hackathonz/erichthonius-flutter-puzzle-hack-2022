part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class RetrieveLeaderboardsInProgress extends LeaderboardState {}

class RetrieveLeaderboardsSuccess extends LeaderboardState {
  final Map<LeaderboardRankingPeriod, Leaderboard> leaderboards;

  RetrieveLeaderboardsSuccess({
    required final this.leaderboards,
  });
}

class RetrieveLeaderboardsFailure extends LeaderboardState {}

class LoadLeaderboardSuccess extends LeaderboardState {
  final Leaderboard leaderboard;

  final LeaderboardRankingPeriod period;

  LoadLeaderboardSuccess({
    required final this.leaderboard,
    required final this.period,
  });
}

class LoadLeaderboardEmpty extends LeaderboardState {}
