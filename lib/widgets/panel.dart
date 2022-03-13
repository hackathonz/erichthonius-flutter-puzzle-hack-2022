import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kPaddingBetweenRankingPositionAndAvatar = EdgeInsets.symmetric(
  vertical: 6.0,
);

const _kPaddingBetweenAvatarAndUsername = EdgeInsets.symmetric(vertical: 6.0);

const _kPaddingBetweenUsernameAndTotalPoints = EdgeInsets.symmetric(
  vertical: 3.0,
);

const _kFirstRankingAvatarAlignment = Alignment(0.0, -0.95);
const _kSecondRankingAvatarAlignment = Alignment(-0.7, 0.0);
const _kThirdRankingAvatarAlignment = Alignment(0.7, 0.0);

const _kPanelHeight = 196.0;

class SwapItLeaderboardPanelEntry extends StatelessWidget {
  final LeaderboardEntry entry;

  const SwapItLeaderboardPanelEntry({
    Key? key,
    required final this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Column(
      children: [
        Text(
          entry.rankingPosition.toString(),
          style: leaderboardPanelRankingPositionTextStyle,
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: _kPaddingBetweenRankingPositionAndAvatar,
        ),
        SwapItAvatar.leaderboardPanel(
          avatar: entry.userProfile.avatar,
        ),
        const Padding(
          padding: _kPaddingBetweenAvatarAndUsername,
        ),
        Text(
          entry.userProfile.username,
          style: leaderboardPanelUsernameTextStyle,
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: _kPaddingBetweenUsernameAndTotalPoints,
        ),
        Text(
          localizations.totalPoints(
            entry.points,
          ),
          style: leaderboardPanelTotalPointsTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
    );
  }
}

class SwapItLeaderboardPanel extends StatelessWidget {
  final List<LeaderboardEntry> topRankingEntries;

  const SwapItLeaderboardPanel({
    Key? key,
    required final this.topRankingEntries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstInRanking = topRankingEntries.first;

    final secondInRanking =
        topRankingEntries.length > 1 ? topRankingEntries[1] : null;

    final thirdInRanking =
        topRankingEntries.length > 2 ? topRankingEntries[2] : null;

    return SizedBox(
      height: _kPanelHeight,
      child: Stack(
        children: [
          if (secondInRanking != null)
            Align(
              alignment: _kSecondRankingAvatarAlignment,
              child: SwapItLeaderboardPanelEntry(
                entry: secondInRanking,
              ),
            ),
          if (thirdInRanking != null)
            Align(
              alignment: _kThirdRankingAvatarAlignment,
              child: SwapItLeaderboardPanelEntry(
                entry: thirdInRanking,
              ),
            ),
          Align(
            alignment: _kFirstRankingAvatarAlignment,
            child: SwapItLeaderboardPanelEntry(
              entry: firstInRanking,
            ),
          ),
        ],
      ),
    );
  }
}
