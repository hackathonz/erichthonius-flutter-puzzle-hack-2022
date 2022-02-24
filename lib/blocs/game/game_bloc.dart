import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/models/models.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late Game game;

  GameBloc() : super(GameInitial());

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is LoadGameStarted) {
      yield* _mapLoadGameStartedToState(event);
    }
  }

  Stream<GameState> _mapLoadGameStartedToState(
    LoadGameStarted event,
  ) async* {
    game = const Game(
      gameLevels: {},
      gameUserProfile: GameUserProfile(
        profile: UserProfile(username: 'Swapper000'),
        levelsPlayed: [],
      ),
    );

    yield LoadGameSuccess(
      game: game,
    );
  }
}
