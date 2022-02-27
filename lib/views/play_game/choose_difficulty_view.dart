import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/routing/routing.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppbarTitleInBetweenPadding = EdgeInsets.symmetric(
  vertical: 5.0,
);

const _kListViewPadding = EdgeInsets.symmetric(
  vertical: 16.0,
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

    return SwapItScaffold(
      appBar: SwapItAppBar(
        bottomTitle: [
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
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => GameLevelDifficultyCard(
          gameLevelDifficulty: mapGameLevelDifficultyForLevelDifficulty(
            LevelDifficulty.values[index],
          ),
          onPressed: () => navigateToChooseLevelView(
            context,
            mapGameLevelDifficultyForLevelDifficulty(
              LevelDifficulty.values[index],
            ),
          ),
        ),
        separatorBuilder: (context, index) => const Padding(
          padding: _kSeparatorPadding,
        ),
        itemCount: LevelDifficulty.values.length,
        padding: _kListViewPadding,
        primary: false,
      ),
    );
  }
}
