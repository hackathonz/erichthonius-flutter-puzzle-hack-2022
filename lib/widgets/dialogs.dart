import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

class SwapItDialog extends StatelessWidget {
  final String title;

  final List<Widget> content;

  const SwapItDialog({
    Key? key,
    required final this.title,
    final this.content = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(
        child: Text(title),
      ),
      titlePadding: kDialogTitlePadding,
      contentPadding: kDialogContentPadding,
      children: [
        ...content.map(
          (x) => Center(
            child: x,
          ),
        ),
      ],
    );
  }
}

class GameFinishDialog extends StatelessWidget {
  final GameLevelPlayEntry playEntry;

  final bool canPlayNextLevel;

  final void Function() onNextLevelPressed;

  final void Function() onRetryPressed;

  final void Function() onExitGamePressed;

  const GameFinishDialog({
    Key? key,
    required final this.playEntry,
    required final this.canPlayNextLevel,
    required final this.onNextLevelPressed,
    required final this.onRetryPressed,
    required final this.onExitGamePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final starsAchieved = playEntry.starsAchieved;

    return SwapItDialog(
      title: localizations.puzzleCompletedDialogTitle,
      content: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0),
        ),
        Row(
          children: [
            for (var i = 0; i < starsAchieved; i++)
              Icon(
                SwapItIcons.star,
                size: kIconGameFinishDialogStarSize,
                color:
                    i + 1 <= starsAchieved ? iconStarColor : iconStarGrayColor,
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0),
          child: Text(
            localizations.puzzleGameTimeFinalScore(
              playEntry.pointsObtained,
            ),
            style: dialogContentTextStyle,
          ),
        ),
        if (canPlayNextLevel)
          SwapItButton(
            text: localizations.nextLevel,
            onPressed: onNextLevelPressed,
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6.5),
        ),
        SwapItButton.alternative(
          text: localizations.retry,
          onPressed: onRetryPressed,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
        SwapItTextButton(
          text: localizations.exitGame,
          onPressed: onExitGamePressed,
        ),
      ],
    );
  }
}

class GameOverDialog extends StatelessWidget {
  final int piecesLeft;

  final void Function() onTryAgainPressed;

  final void Function() onExitGamePressed;

  const GameOverDialog({
    Key? key,
    required final this.piecesLeft,
    required final this.onExitGamePressed,
    required final this.onTryAgainPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SwapItDialog(
      title: localizations.puzzleNotCompletedDialogTitle,
      content: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 9.0),
        ),
        Text(
          localizations.puzzleNotCompletedDialogPiecesLeft(
            piecesLeft,
          ),
          style: dialogContentTextStyle,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 26.0),
        ),
        SwapItButton(
          text: localizations.tryAgain,
          onPressed: onTryAgainPressed,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
        SwapItTextButton(
          text: localizations.exitGame,
          onPressed: onExitGamePressed,
        ),
      ],
    );
  }
}

void showSwapItDialog({
  required final BuildContext context,
  required final Widget Function(BuildContext) dialogBuilder,
  required final RouteSettings routeSettings,
}) {
  showDialog(
    context: context,
    builder: dialogBuilder,
    barrierColor: dialogBarrierColor,
    routeSettings: routeSettings,
    barrierDismissible: false,
  );
}
