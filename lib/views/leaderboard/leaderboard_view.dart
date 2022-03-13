import 'package:flutter/material.dart';
import 'package:swap_it/l10n/l10n.dart';
import 'package:swap_it/widgets/scaffold.dart';
import 'package:swap_it/widgets/widgets.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SwapItScaffold(
      scaffoldPadding: EdgeInsets.zero,
      appBar: SwapItAppBar(
        title: localizations.leaderboardTitle,
      ),
      body: Column(
        children: [
          Container(
            padding: kScaffoldPadding,
            child: SwapItTabBar(
              tabs: [
                TabOption(
                  label: localizations.today,
                  isActive: false,
                  onPressed: () {},
                ),
                TabOption(
                  label: localizations.week,
                  isActive: true,
                  onPressed: () {},
                ),
                TabOption(
                  label: localizations.month,
                  isActive: false,
                  onPressed: () {},
                ),
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  kLeaderboardCornerRadius,
                ),
                bottomRight: Radius.circular(
                  kLeaderboardCornerRadius,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                primary: false,
              ),
              color: leaderboardViewBackgroundColor,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
