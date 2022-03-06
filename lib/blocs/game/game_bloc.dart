import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;

  late Game game;

  GameBloc({
    required final this.gameRepository,
  }) : super(GameInitial());

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is LoadGameStarted) {
      yield* _mapLoadGameStartedToState(event);
    } else if (event is PlayGameLevelStarted) {
      yield* _mapPlayGameLevelStartedToState(event);
    } else if (event is SaveGameStarted) {
      yield* _mapSaveGameStartedToState(event);
    } else if (event is SaveGameLevelPlayEntryStarted) {
      yield* _mapSaveGameLevelPlayEntryStartedToState(event);
    } else if (event is PlayNextGameLevelStarted) {
      yield* _mapPlayNextGameLevelStartedToState(event);
    }
  }

  Stream<GameState> _mapLoadGameStartedToState(
    LoadGameStarted event,
  ) async* {
    try {
      game = await gameRepository.loadGame();

      yield LoadGameSuccess(
        game: game,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield LoadGameFailure();
    }
  }

  Stream<GameState> _mapPlayGameLevelStartedToState(
    PlayGameLevelStarted event,
  ) async* {
    if (game.canPlayLevel(event.gameLevel)) {
      yield StartPlayGameLevelInitial(
        gameLevel: event.gameLevel,
      );
    } else {
      yield PlayGameLevelFailure();
    }
  }

  Stream<GameState> _mapSaveGameStartedToState(
    SaveGameStarted event,
  ) async* {
    try {
      await gameRepository.saveGame(game);

      yield SaveGameSuccess(
        game: game,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield SaveGameFailure();
    }
  }

  Stream<GameState> _mapSaveGameLevelPlayEntryStartedToState(
    SaveGameLevelPlayEntryStarted event,
  ) async* {
    game.registerPlayEntry(event.gameLevelPlayEntry);

    yield SaveGameLevelPlayEntrySuccess();

    add(SaveGameStarted());
  }

  Stream<GameState> _mapPlayNextGameLevelStartedToState(
    PlayNextGameLevelStarted event,
  ) async* {
    final gameLevels = game.gameLevels
        .where(
          (x) => x.difficulty == event.previousGameLevel.difficulty,
        )
        .toList();

    final indexOfPreviousGameLevel =
        gameLevels.indexOf(event.previousGameLevel);

    final nextGameLevel = gameLevels[indexOfPreviousGameLevel + 1];

    yield StartPlayGameLevelInitial(
      gameLevel: nextGameLevel,
    );
  }
}
