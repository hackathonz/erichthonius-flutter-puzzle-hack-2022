import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppBarPaddingBetweenTimeLeftAndTimeCaps = EdgeInsets.symmetric(
  vertical: 4.0,
);

class PlayGameView extends StatelessWidget {
  const PlayGameView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final playGameLevelBloc = context.read<PlayGameLevelBloc>();
    final gameBloc = context.read<GameBloc>();

    final gameLevel = playGameLevelBloc.gameLevel;

    late ConfettiController confettiController;

    return SwapItScaffold(
      appBar: SwapItAppBar.game(
        gameLevel: gameLevel,
        bottomTitle: [
          BlocBuilder<PlayGameLevelBloc, PlayGameLevelState>(
            buildWhen: (previous, current) => current is GameLevelUpdate,
            builder: (context, state) {
              return Text(
                localizations.puzzleGameTimeLeft(
                  state is GameLevelUpdate
                      ? state.timeLeftInSeconds
                      : gameLevel.difficulty.gameDuration.inSeconds,
                ),
                style: state is GameLevelUpdate
                    ? state.alertTimeLeft
                        ? alertTimeLeftTextStyle
                        : timeLeftTextStyle
                    : timeLeftTextStyle,
              );
            },
          ),
          const Padding(
            padding: _kAppBarPaddingBetweenTimeLeftAndTimeCaps,
          ),
          Text(
            localizations.timeCaps,
            style: timeCapsTextStyle,
          ),
        ],
      ),
      body: BlocListener<PlayGameLevelBloc, PlayGameLevelState>(
        listenWhen: (previous, current) =>
            current is GameLevelFinish ||
            current is GameLevelNotFinish ||
            current is PlayNextLevelSuccess,
        listener: (context, state) {
          if (state is GameLevelNotFinish) {
            _onGameLevelNotFinishStateReact(
              context,
              state,
              playGameLevelBloc,
              gameBloc,
            );
          } else if (state is GameLevelFinish) {
            _onGameLevelFinishStateReact(
              context,
              state,
              playGameLevelBloc,
              gameBloc,
              confettiController,
            );
          } else if (state is PlayNextLevelSuccess) {
            _onPlayNextLevelSuccessStateReact(
              context,
              gameBloc,
              gameLevel,
            );
          }
        },
        child: ConfettiAnimation(
          onControllerCreate: (controller) => confettiController = controller,
          blastDirectionality: BlastDirectionality.explosive,
          child: Center(
            child: BlocBuilder<PlayGameLevelBloc, PlayGameLevelState>(
              buildWhen: (previous, current) => current is GameLevelInitial,
              builder: (context, state) {
                if (state is GameLevelInitial) {
                  return PuzzleGame(
                    tiles: state.tiles,
                    difficulty: state.difficulty,
                    onTileMove: (puzzleTiles) {
                      playGameLevelBloc.add(
                        GameLevelTilesUpdated(
                          puzzleTiles: puzzleTiles,
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
      scaffoldPadding: kScaffoldPadding + kGameLevelPadding,
      bottomButton: SwapItButton(
        text: localizations.shuffle,
        onPressed: () {
          playGameLevelBloc.add(
            ShuffleGameLevelStarted(),
          );
        },
      ),
    );
  }

  void _onGameLevelNotFinishStateReact(
    final BuildContext context,
    final GameLevelNotFinish state,
    final PlayGameLevelBloc playGameLevelBloc,
    final GameBloc gameBloc,
  ) {
    gameBloc.add(
      SaveGameLevelPlayEntryStarted(
        gameLevelPlayEntry: state.results,
      ),
    );

    showSwapItDialog(
      context: context,
      dialogBuilder: (dialogContext) {
        return GameOverDialog(
          piecesLeft: state.results.piecesLeftForCompletion,
          onExitGamePressed: () {
            Navigator.of(dialogContext).pop();
            Navigator.of(context).pop();
          },
          onTryAgainPressed: () {
            Navigator.of(dialogContext).pop();

            playGameLevelBloc.add(
              GameLevelRestarted(),
            );
          },
        );
      },
      routeSettings: const RouteSettings(
        name: '/game_over_dialog',
      ),
    );
  }

  void _onGameLevelFinishStateReact(
    final BuildContext context,
    final GameLevelFinish state,
    final PlayGameLevelBloc playGameLevelBloc,
    final GameBloc gameBloc,
    final ConfettiController confettiController,
  ) {
    gameBloc.add(
      SaveGameLevelPlayEntryStarted(
        gameLevelPlayEntry: state.results,
      ),
    );

    confettiController.play();

    showSwapItDialog(
      context: context,
      dialogBuilder: (dialogContext) {
        return GameFinishDialog(
          playEntry: state.results,
          canPlayNextLevel: state.canPlayNextLevel,
          onExitGamePressed: () {
            Navigator.of(dialogContext).pop();
            Navigator.of(context).pop();
          },
          onNextLevelPressed: () {
            Navigator.of(dialogContext).pop();

            playGameLevelBloc.add(
              PlayNextLevelStarted(),
            );
          },
          onRetryPressed: () {
            Navigator.of(dialogContext).pop();

            playGameLevelBloc.add(
              GameLevelRestarted(),
            );
          },
        );
      },
      routeSettings: const RouteSettings(
        name: '/game_level_finish_dialog',
      ),
    );
  }

  void _onPlayNextLevelSuccessStateReact(
    final BuildContext context,
    final GameBloc gameBloc,
    final GameLevel currentGameLevel,
  ) {
    Navigator.of(context).pop();

    gameBloc.add(
      PlayNextGameLevelStarted(
        previousGameLevel: currentGameLevel,
      ),
    );
  }
}
