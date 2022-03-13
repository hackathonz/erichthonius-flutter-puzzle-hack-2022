import 'package:flutter/material.dart';
import 'package:swap_it/l10n/l10n.dart';
import 'package:swap_it/models/leaderboard.dart';
import 'package:swap_it/models/profile.dart';
import 'package:swap_it/widgets/scaffold.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kLeaderboardPanelPadding = EdgeInsets.symmetric(vertical: 17.0);

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
      body: Container(
        child: Column(
          children: [
            Container(
              padding: kScaffoldPadding,
              child: Column(
                children: [
                  SwapItTabBar(
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
                  Padding(
                    padding: _kLeaderboardPanelPadding,
                    child: SwapItLeaderboardPanel(
                      topRankingEntries: [
                        LeaderboardEntry(
                          points: 500,
                          rankingPosition: 1,
                          userProfile: UserProfile(
                            username: 'Swapper764',
                            avatar: const Avatar(data: '😎', isUrl: false),
                            dateJoined: DateTime.now(),
                          ),
                        ),
                        LeaderboardEntry(
                          points: 500,
                          rankingPosition: 1,
                          userProfile: UserProfile(
                            username: 'Swapper764',
                            avatar: const Avatar(data: '😎', isUrl: false),
                            dateJoined: DateTime.now(),
                          ),
                        ),
                        LeaderboardEntry(
                          points: 500,
                          rankingPosition: 1,
                          userProfile: UserProfile(
                            username: 'Swapper764',
                            avatar: const Avatar(data: '😎', isUrl: false),
                            dateJoined: DateTime.now(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    kLeaderboardCornerRadius,
                  ),
                  bottomRight: Radius.circular(
                    kLeaderboardCornerRadius,
                  ),
                ),
                gradient: backgroundDecoration.gradient,
              ),
            ),
            Expanded(
              child: ListView(
                primary: false,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        color: leaderboardViewBackgroundColor,
      ),
    );
  }
}
