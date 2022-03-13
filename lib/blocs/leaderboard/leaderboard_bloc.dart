import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final LeaderboardRepository leaderboardRepository;

  final Map<LeaderboardRankingPeriod, Leaderboard> _leaderboards = {};

  LeaderboardBloc({
    required final this.leaderboardRepository,
  }) : super(LeaderboardInitial());

  @override
  Stream<LeaderboardState> mapEventToState(LeaderboardEvent event) async* {
    if (event is RetrieveLeaderboardsStarted) {
      yield* _mapRetrieveLeaderboardsStartedToState(event);
    } else if (event is LoadLeaderboardStarted) {
      yield* _mapLoadLeaderboardStartedToState(event);
    }
  }

  Stream<LeaderboardState> _mapRetrieveLeaderboardsStartedToState(
    RetrieveLeaderboardsStarted event,
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

      _leaderboards.clear();

      _leaderboards.addAll(
        {
          LeaderboardRankingPeriod.today: todayLeaderboard,
          LeaderboardRankingPeriod.weekly: weeklyLeaderboard,
          LeaderboardRankingPeriod.monthly: monthlyLeaderboard,
        },
      );

      yield RetrieveLeaderboardsSuccess(
        leaderboards: _leaderboards,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield RetrieveLeaderboardsFailure();
    }
  }

  Stream<LeaderboardState> _mapLoadLeaderboardStartedToState(
    LoadLeaderboardStarted event,
  ) async* {
    final period = event.period;

    final leaderboard = _leaderboards[period];

    if (leaderboard == null) {
      yield LoadLeaderboardEmpty();
    } else {
      yield LoadLeaderboardSuccess(
        leaderboard: leaderboard,
        period: period,
      );
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
