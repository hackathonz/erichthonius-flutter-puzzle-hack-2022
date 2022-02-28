import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppBarPaddingBetweenTimeLeftAndTimeCaps = EdgeInsets.symmetric(
  vertical: 4.0,
);

class PlayGameView extends StatelessWidget {
  final GameLevel gameLevel;

  const PlayGameView({
    Key? key,
    required final this.gameLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SwapItScaffold(
      appBar: SwapItAppBar.game(
        gameLevel: gameLevel,
        bottomTitle: [
          Text(
            localizations.puzzleGameTimeLeft(
              gameLevel.difficulty.gameDuration.inSeconds,
            ),
            style: timeLeftTextStyle,
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
      body: const Center(),
    );
  }
}
