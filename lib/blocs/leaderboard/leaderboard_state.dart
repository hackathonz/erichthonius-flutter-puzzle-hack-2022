part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardState {}

class LeaderboardInitial extends LeaderboardState {}

class LoadLeaderboardsInProgress extends LeaderboardState {}

class LoadLeaderboardsSuccess extends LeaderboardState {
  final Leaderboard todayLeaderboard;

  final Leaderboard weeklyLeaderboard;

  final Leaderboard monthlyLeaderboard;

  LoadLeaderboardsSuccess({
    required final this.todayLeaderboard,
    required final this.weeklyLeaderboard,
    required final this.monthlyLeaderboard,
  });
}

class LoadLeaderboardsEmpty extends LeaderboardState {}

class LoadLeaderboardsFailure extends LeaderboardState {}
