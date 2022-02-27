import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
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
      gameLevels: [
        GameLevel(
          id: '1',
          difficulty: kGameLevelEasyDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '2',
          difficulty: kGameLevelEasyDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 150.0,
            y: 285.0,
          ),
        ),
        GameLevel(
          id: '3',
          difficulty: kGameLevelEasyDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 230.0,
            y: 490.0,
          ),
        ),
        GameLevel(
          id: '4',
          difficulty: kGameLevelEasyDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 26.5,
            y: 623.5,
          ),
        ),
        GameLevel(
          id: '5',
          difficulty: kGameLevelEasyDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 178.5,
            y: 780.5,
          ),
        ),
        GameLevel(
          id: '1',
          difficulty: kGameLevelMediumDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '2',
          difficulty: kGameLevelMediumDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '3',
          difficulty: kGameLevelMediumDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '4',
          difficulty: kGameLevelMediumDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '5',
          difficulty: kGameLevelMediumDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '1',
          difficulty: kGameLevelHardDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '2',
          difficulty: kGameLevelHardDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '3',
          difficulty: kGameLevelHardDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '4',
          difficulty: kGameLevelHardDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '5',
          difficulty: kGameLevelHardDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
        GameLevel(
          id: '6',
          difficulty: kGameLevelHardDifficulty,
          point: LevelMarkerPoint(
            mapSize: Size(390.0, 844.0),
            x: 27.5,
            y: 80.0,
          ),
        ),
      ],
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
