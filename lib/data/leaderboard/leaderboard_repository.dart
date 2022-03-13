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
    throw UnimplementedError();
  }
}
