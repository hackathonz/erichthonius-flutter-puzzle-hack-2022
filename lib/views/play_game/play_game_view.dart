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
      body: Center(
        child: BlocBuilder<PlayGameLevelBloc, PlayGameLevelState>(
          buildWhen: (previous, current) => current is GameLevelInitial,
          builder: (context, state) {
            if (state is GameLevelInitial) {
              return PuzzleGame(
                tiles: state.tiles,
                difficulty: state.difficulty,
                onTileTap: print,
              );
            } else {
              return Container();
            }
          },
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
}
