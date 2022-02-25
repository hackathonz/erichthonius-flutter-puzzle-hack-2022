import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kHorizontalPadding = EdgeInsets.symmetric(
  horizontal: 24.0,
);

const _kListViewPadding = EdgeInsets.symmetric(
  vertical: 16.0,
);

const _kAppbarTitleInBetweenPadding = EdgeInsets.symmetric(
  vertical: 5.0,
);

const _kSeparatorPadding = EdgeInsets.symmetric(
  vertical: 8.0,
);

class ChooseDifficultyView extends StatelessWidget {
  const ChooseDifficultyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final gameBloc = context.read<GameBloc>();

    final game = gameBloc.game;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            SwapItIcons.back,
          ),
          onPressed: Navigator.of(context).pop,
        ),
        bottom: PreferredSize(
          child: Padding(
            padding: _kHorizontalPadding,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    localizations.welcomeUser(
                      game.gameUserProfile.profile.username,
                    ),
                    style: welcomeUserTextStyle,
                  ),
                  const Padding(
                    padding: _kAppbarTitleInBetweenPadding,
                  ),
                  Text(
                    localizations.chooseDifficulty,
                    style: chooseDifficultyTextStyle,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(kToolbarHeight),
        ),
      ),
      body: Padding(
        padding: _kHorizontalPadding,
        child: ListView.separated(
          itemBuilder: (context, index) => GameLevelDifficultyCard(
            gameLevelDifficulty: game.gameLevels.keys.elementAt(index),
          ),
          separatorBuilder: (context, index) => const Padding(
            padding: _kSeparatorPadding,
          ),
          itemCount: game.gameLevels.keys.length,
          padding: _kListViewPadding,
          primary: false,
        ),
      ),
    );
  }
}
