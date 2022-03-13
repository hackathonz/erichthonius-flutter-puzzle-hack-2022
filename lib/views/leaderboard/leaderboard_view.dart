import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/l10n.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/scaffold.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kLeaderboardPanelPadding = EdgeInsets.symmetric(vertical: 17.0);

const _kLeaderboardListViewPadding = EdgeInsets.symmetric(vertical: 24.0);

const _kLeaderboardListViewTilePadding = EdgeInsets.symmetric(horizontal: 24.0);

const _kLeaderboardListViewTileSeparatorPadding = EdgeInsets.symmetric(
  vertical: 12.0,
);

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final leaderboardBloc = context.read<LeaderboardBloc>();

    return SwapItScaffold(
      scaffoldPadding: EdgeInsets.zero,
      appBar: SwapItAppBar(
        title: localizations.leaderboardTitle,
      ),
      body: Container(
        child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
          buildWhen: (previous, current) => current is LoadLeaderboardSuccess,
          builder: (context, state) {
            if (state is LoadLeaderboardSuccess) {
              return Column(
                children: [
                  Container(
                    padding: kScaffoldPadding,
                    child: Column(
                      children: [
                        SwapItTabBar(
                          tabs: [
                            TabOption(
                              label: localizations.today,
                              isActive: state.period ==
                                  LeaderboardRankingPeriod.today,
                              onPressed: () {
                                leaderboardBloc.add(
                                  LoadLeaderboardStarted(
                                    period: LeaderboardRankingPeriod.today,
                                  ),
                                );
                              },
                            ),
                            TabOption(
                              label: localizations.week,
                              isActive: state.period ==
                                  LeaderboardRankingPeriod.weekly,
                              onPressed: () {
                                leaderboardBloc.add(
                                  LoadLeaderboardStarted(
                                    period: LeaderboardRankingPeriod.weekly,
                                  ),
                                );
                              },
                            ),
                            TabOption(
                              label: localizations.month,
                              isActive: state.period ==
                                  LeaderboardRankingPeriod.monthly,
                              onPressed: () {
                                leaderboardBloc.add(
                                  LoadLeaderboardStarted(
                                    period: LeaderboardRankingPeriod.monthly,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: _kLeaderboardPanelPadding,
                          child: SwapItLeaderboardPanel(
                            topRankingEntries: state.leaderboard.topRanking,
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
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: _kLeaderboardListViewTilePadding,
                          child: SwapItListLeaderboardListTile(
                            entry: state.leaderboard.entries[index],
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const Padding(
                        padding: _kLeaderboardListViewTileSeparatorPadding,
                      ),
                      itemCount: state.leaderboard.entries.length,
                      padding: _kLeaderboardListViewPadding,
                      primary: false,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        color: leaderboardViewBackgroundColor,
      ),
    );
  }
}
