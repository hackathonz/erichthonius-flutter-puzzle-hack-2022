import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_it/data/game/game_levels.dart';
import 'package:swap_it/models/models.dart';

abstract class GameRepository {
  Future<Game> loadGame();

  Future<void> saveGame(final Game game);
}

class RealGameRepository extends GameRepository {
  final FirebaseFirestore firestore;

  final String deviceId;

  RealGameRepository({
    required final this.deviceId,
    required final this.firestore,
  });

  @override
  Future<Game> loadGame() async {
    final gameDoc = await firestore.collection('games').doc(deviceId).get();

    late Game game;

    if (gameDoc.exists) {
      game = Game.fromJson(
        gameDoc.data()!,
        defaultGameLevels,
      );
    } else {
      final id = Random().nextInt(1000);

      final idString = id < 10
          ? '00$id'
          : id < 100
              ? '0$id'
              : '$id';

      game = Game(
        gameUserProfile: GameUserProfile(
          profile: UserProfile(
            avatar: const Avatar(
              data: '😎',
              isUrl: false,
            ),
            username: 'Swapper$idString',
            dateJoined: DateTime.now(),
          ),
          levelsPlayed: [],
        ),
        gameLevels: defaultGameLevels,
      );

      await saveGame(game);
    }

    return game;
  }

  @override
  Future<void> saveGame(Game game) async {
    final gameDoc = firestore.collection('games').doc(deviceId);

    return gameDoc.set(
      game.toJson(),
    );
  }
}

class MockGameRepository extends GameRepository {
  late Game game;

  @override
  Future<Game> loadGame() {
    final id = Random().nextInt(1000);

    final idString = id < 10
        ? '00$id'
        : id < 100
            ? '0$id'
            : '$id';

    game = Game(
      gameLevels: defaultMockGameLevels,
      gameUserProfile: GameUserProfile(
        profile: UserProfile(
          avatar: const Avatar(
            data: '😎',
            isUrl: false,
          ),
          username: 'Swapper$idString',
          dateJoined: DateTime.now(),
        ),
        levelsPlayed: [],
      ),
    );

    return Future.value(game);
  }

  @override
  Future<void> saveGame(Game game) {
    this.game = game;

    return Future.value();
  }
}
