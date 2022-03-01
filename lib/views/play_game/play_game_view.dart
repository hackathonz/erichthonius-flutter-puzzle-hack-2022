import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
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

    final gameLevel = playGameLevelBloc.gameLevel;

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
            current is GameLevelFinish || current is GameLevelNotFinish,
        listener: (context, state) {
          if (state is GameLevelNotFinish) {
            _onGameLevelNotFinishStateReact(context, state, playGameLevelBloc);
          }
        },
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
  ) {
    showSwapItDialog(
      context: context,
      dialogBuilder: (dialogContext) {
        return GameOverDialog(
          piecesLeft: state.piecesLeft,
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
}
