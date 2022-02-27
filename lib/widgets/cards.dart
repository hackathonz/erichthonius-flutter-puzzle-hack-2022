import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kCardContentPadding = EdgeInsets.symmetric(
  horizontal: 24.0,
);

const _kCardTitleAndSubtitlePadding = EdgeInsets.symmetric(
  vertical: 8.0,
);

class GameLevelDifficultyCard extends StatelessWidget {
  final GameLevelDifficulty gameLevelDifficulty;

  final void Function() onPressed;

  const GameLevelDifficultyCard({
    Key? key,
    required final this.gameLevelDifficulty,
    required final this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return GestureDetector(
      child: SizedBox.fromSize(
        size: kCardSize,
        child: Card(
          child: Padding(
            padding: _kCardContentPadding,
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      localizations.difficulty(
                        gameLevelDifficulty.difficulty,
                      ),
                      style: gameLevelDifficultyCardTitleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                    const Padding(
                      padding: _kCardTitleAndSubtitlePadding,
                    ),
                    Text(
                      localizations.piecesCount(
                        gameLevelDifficulty.pieces,
                      ),
                      style: gameLevelDifficultyCardSubtitleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                mapPreviewForDifficulty(
                  gameLevelDifficulty.difficulty,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ),
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
    );
  }
}
