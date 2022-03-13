part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardEvent {}

class LoadLeaderboardsStarted extends LeaderboardEvent {}

class RefreshLeaderboardsStarted extends LoadLeaderboardsStarted {}
