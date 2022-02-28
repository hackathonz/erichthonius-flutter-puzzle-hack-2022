import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppBarHorizontalPadding = EdgeInsets.symmetric(
  horizontal: 24.0,
);

class SwapItAppBar extends AppBar {
  SwapItAppBar({
    Key? key,
    final IconData leadingIconData = SwapItIcons.back,
    final void Function()? leadingPressCallback,
    final String? title,
    final List<Widget> bottomTitle = const [],
  }) : super(
          key: key,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  leadingIconData,
                ),
                onPressed: leadingPressCallback ?? Navigator.of(context).pop,
              );
            },
          ),
          bottom: bottomTitle.isNotEmpty
              ? PreferredSize(
                  child: Padding(
                    padding: _kAppBarHorizontalPadding,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: bottomTitle,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                )
              : null,
          title: title != null
              ? Text(
                  title,
                )
              : null,
        );

  SwapItAppBar.game({
    Key? key,
    required final GameLevel gameLevel,
    final void Function()? trailingPressCallback,
    final List<Widget> bottomTitle = const [],
  }) : super(
          key: key,
          leading: Builder(
            builder: (context) {
              final localizations = AppLocalizations.of(context);

              return Align(
                child: Text(
                  localizations.puzzleGameLevel(
                    gameLevel.id,
                  ),
                  style: appBarGameLevelIdTextStyle,
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.center,
              );
            },
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    SwapItIcons.close,
                  ),
                  onPressed: trailingPressCallback ?? Navigator.of(context).pop,
                );
              },
            ),
          ],
          bottom: bottomTitle.isNotEmpty
              ? PreferredSize(
                  child: Padding(
                    padding: _kAppBarHorizontalPadding,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: bottomTitle,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  ),
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                )
              : null,
          title: Row(
            children: [
              const Icon(
                SwapItIcons.star,
                size: kIconAppBarTitleSize,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 1.5,
                ),
              ),
              Text(
                gameLevel.difficulty.pieces.toString(),
                style: appBarGameLevelPiecesCountTextStyle,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
}
