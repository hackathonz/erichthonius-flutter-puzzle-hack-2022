import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/routing/routing.dart';
import 'package:swap_it/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final gameBloc = context.read<GameBloc>();

    final showContinueButton = gameBloc.game.gameUserProfile.hasPlayedAnyGame;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: SwapItScaffold(
        scaffoldPadding: EdgeInsets.zero,
        body: Center(
          child: ListView(
            children: [
              const SwapItAlternativeLogo(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 44.0 + (!showContinueButton ? 12.0 : 0.0),
                ),
              ),
              SwapItButton(
                text: localizations.play,
                onPressed: () => navigateToChooseDifficultyView(context),
              ),
              if (showContinueButton)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: SwapItButton(
                    text: localizations.ccontinue,
                    onPressed: () {},
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 44.0),
              ),
            ],
            primary: false,
          ),
        ),
        navigationBarSettings: SwapItNavigationBarSettings(
          onProfileItemPressed: () {
            navigateToProfileView(
              context,
              gameBloc.game.gameUserProfile.profile,
            );
          },
          onLeaderboardItemPressed: () {
            navigateToLeaderboardView(context);
          },
          onSettingsItemPressed: () {
            navigateToSettingsView(context);
          },
        ),
      ),
    );
  }
}
