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
      gameLevels: {
        GameLevelDifficulty(
          difficulty: LevelDifficulty.easy,
          pieces: 9,
        ): [
          GameLevel(
            id: '1',
            difficulty: LevelDifficulty.easy,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '2',
            difficulty: LevelDifficulty.easy,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 150.0,
              y: 285.0,
            ),
          ),
          GameLevel(
            id: '3',
            difficulty: LevelDifficulty.easy,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 230.0,
              y: 490.0,
            ),
          ),
          GameLevel(
            id: '4',
            difficulty: LevelDifficulty.easy,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 26.5,
              y: 623.5,
            ),
          ),
          GameLevel(
            id: '5',
            difficulty: LevelDifficulty.easy,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 178.5,
              y: 780.5,
            ),
          ),
        ],
        GameLevelDifficulty(
          difficulty: LevelDifficulty.medium,
          pieces: 16,
        ): [
          GameLevel(
            id: '1',
            difficulty: LevelDifficulty.medium,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '2',
            difficulty: LevelDifficulty.medium,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '3',
            difficulty: LevelDifficulty.medium,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '4',
            difficulty: LevelDifficulty.medium,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '5',
            difficulty: LevelDifficulty.medium,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
        ],
        GameLevelDifficulty(
          difficulty: LevelDifficulty.hard,
          pieces: 25,
        ): [
          GameLevel(
            id: '1',
            difficulty: LevelDifficulty.hard,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '2',
            difficulty: LevelDifficulty.hard,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '3',
            difficulty: LevelDifficulty.hard,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '4',
            difficulty: LevelDifficulty.hard,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '5',
            difficulty: LevelDifficulty.hard,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
          GameLevel(
            id: '6',
            difficulty: LevelDifficulty.hard,
            point: LevelMarkerPoint(
              mapSize: Size(390.0, 844.0),
              x: 27.5,
              y: 80.0,
            ),
          ),
        ],
      },
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
