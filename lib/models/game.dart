import 'package:swap_it/models/models.dart';

class Game {
  final GameUserProfile gameUserProfile;

  final Map<GameLevelDifficulty, GameLevel> gameLevels;

  const Game({
    required final this.gameUserProfile,
    required final this.gameLevels,
  });
}