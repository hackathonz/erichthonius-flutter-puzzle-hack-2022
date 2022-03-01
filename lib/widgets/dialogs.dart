import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
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
