import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final LeaderboardRepository leaderboardRepository;

  late Leaderboard todayLeaderboard;

  late Leaderboard weeklyLeaderboard;

  late Leaderboard monthlyLeaderboard;

  LeaderboardBloc({
    required final this.leaderboardRepository,
  }) : super(LeaderboardInitial());

  @override
  Stream<LeaderboardState> mapEventToState(LeaderboardEvent event) async* {
    if (event is LoadLeaderboardsStarted) {
      yield* _mapLoadLeaderboardsStartedToState(event);
    }
  }

  Stream<LeaderboardState> _mapLoadLeaderboardsStartedToState(
    LoadLeaderboardsStarted event,
  ) async* {
    try {
      final currentDateTime = DateTime.now();

      final todayLeaderboard = await _loadLeaderboard(
        from: currentDateTime.subtract(const Duration(days: 1)),
        to: currentDateTime,
      );

      final weeklyLeaderboard = await _loadLeaderboard(
        from: currentDateTime.subtract(Duration(days: currentDateTime.weekday)),
        to: currentDateTime,
      );

      final monthlyLeaderboard = await _loadLeaderboard(
        from: DateTime(currentDateTime.year, currentDateTime.month),
        to: currentDateTime,
      );

      if (monthlyLeaderboard.entries.isEmpty) {
        yield LoadLeaderboardsEmpty();
      } else {
        yield LoadLeaderboardsSuccess(
          todayLeaderboard: todayLeaderboard,
          weeklyLeaderboard: weeklyLeaderboard,
          monthlyLeaderboard: monthlyLeaderboard,
        );
      }
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield LoadLeaderboardsFailure();
    }
  }

  Future<Leaderboard> _loadLeaderboard({
    required final DateTime from,
    required final DateTime to,
  }) async {
    final entries = await leaderboardRepository.retrieveEntries(
      from: from,
      to: to,
    );

    entries.sort((x, y) => x.rankingPosition.compareTo(y.rankingPosition));

    return Leaderboard(
      entries: [
        ...entries.skip(3),
      ],
      topRanking: [
        ...entries.take(3),
      ],
    );
  }
}
