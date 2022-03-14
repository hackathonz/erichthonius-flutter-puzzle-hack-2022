import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/routing/routing.dart';
import 'package:swap_it/widgets/widgets.dart';

class ChooseLevelView extends StatelessWidget {
  final GameLevelDifficulty gameLevelDifficulty;

  const ChooseLevelView({
    Key? key,
    required final this.gameLevelDifficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = context.read<GameBloc>();

    final gameLevels = gameBloc.game.gameLevels.where(
      (x) => x.difficulty == gameLevelDifficulty,
    );

    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) => current is StartPlayGameLevelInitial,
      listener: (context, state) {
        if (state is StartPlayGameLevelInitial) {
          _onStartPlayGameLevelInitialStateReact(context, state);
        }
      },
      child: SwapItScaffold(
        appBar: SwapItAppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                mapForDifficulty(
                  gameLevelDifficulty.difficulty,
                ),
                ...gameLevels.map(
                  (x) => Positioned(
                    bottom: x.point.y.toDouble(),
                    right: x.point.x.toDouble(),
                    child: LevelMarker(
                      level: x,
                      isLocked: !gameBloc.game.canPlayLevel(x),
                      onPressed: () {
                        gameBloc.add(
                          PlayGameLevelStarted(
                            gameLevel: x,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onStartPlayGameLevelInitialStateReact(
    final BuildContext context,
    final StartPlayGameLevelInitial state,
  ) {
    navigateToPlayGameView(
      context,
      state.gameLevel,
      state.isLastLevel,
    );
  }
}
