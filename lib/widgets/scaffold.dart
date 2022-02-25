import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kBottomNavigationBarSelectedFontSize = 32.0;
const _kBottomNavigationBarUnselectedFontSize = 32.0;

class SwapItScaffold extends StatelessWidget {
  final Widget body;

  final SwapItAppBar? appBar;

  final SwapItNavigationBarSettings? navigationBarSettings;

  final EdgeInsets scaffoldPadding;

  const SwapItScaffold({
    Key? key,
    required final this.body,
    final this.appBar,
    final this.navigationBarSettings,
    final this.scaffoldPadding = kScaffoldPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: scaffoldPadding,
        child: body,
      ),
      bottomNavigationBar: navigationBarSettings != null
          ? Builder(
              builder: (context) {
                final localizations = AppLocalizations.of(context);

                return BottomNavigationBar(
                  selectedFontSize: _kBottomNavigationBarSelectedFontSize,
                  unselectedFontSize: _kBottomNavigationBarUnselectedFontSize,
                  items: [
                    BottomNavigationBarItem(
                      label: localizations.profileDetailsTitle,
                      icon: IconBase(
                        key: const Key(
                          'bottom_navigation_bar_profile_item',
                        ),
                        child: const Icon(
                          SwapItIcons.profile,
                        ),
                        onPressed: navigationBarSettings!.onProfileItemPressed,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: localizations.play,
                      icon: IconBase.alternative(
                        key: const Key(
                          'bottom_navigation_bar_play_item',
                        ),
                        child: const Icon(
                          SwapItIcons.cup,
                          size: kIconAlternativeSize,
                        ),
                        onPressed:
                            navigationBarSettings!.onLeaderboardItemPressed,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: localizations.settingsTitle,
                      icon: IconBase(
                        key: const Key(
                          'bottom_navigation_bar_settings_item',
                        ),
                        child: const Icon(
                          SwapItIcons.settings,
                        ),
                        onPressed: navigationBarSettings!.onSettingsItemPressed,
                      ),
                    ),
                  ],
                );
              },
            )
          : null,
    );
  }
}

class SwapItNavigationBarSettings {
  final void Function() onProfileItemPressed;

  final void Function() onLeaderboardItemPressed;

  final void Function() onSettingsItemPressed;

  const SwapItNavigationBarSettings({
    required final this.onLeaderboardItemPressed,
    required final this.onProfileItemPressed,
    required final this.onSettingsItemPressed,
  });
}
