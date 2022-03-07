import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/main.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/views/views.dart';

Future<void> navigateToChooseDifficultyView(final BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const ChooseDifficultyView();
      },
    ),
  );
}

Future<void> navigateToChooseLevelView(
  final BuildContext context,
  final GameLevelDifficulty gameLevelDifficulty,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return ChooseLevelView(
          gameLevelDifficulty: gameLevelDifficulty,
        );
      },
    ),
  );
}

Future<void> navigateToPlayGameView(
  final BuildContext context,
  final GameLevel gameLevel,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return BlocProvider(
          create: (context) => PlayGameLevelBloc(
            gameLevel: gameLevel,
          )..add(GameLevelStarted()),
          child: const PlayGameView(),
        );
      },
    ),
  );
}

Future<void> navigateToProfileView(
  final BuildContext context,
  final UserProfile userProfile,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return BlocProvider(
          create: (context) => ProfileBloc(
            userProfile: userProfile,
            profileRepository:
                context.read<Vault>().lookup<ProfileRepository>(),
          ),
          child: const ProfileView(),
        );
      },
    ),
  );
}

Future<void> navigateToSettingsView(final BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const SettingsView();
      },
    ),
  );
}

Future<void> navigateToChangeAvatarView(
  final BuildContext context,
  final ProfileBloc profileBloc,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return BlocProvider(
          create: (context) => AvatarBloc(
            userProfile: profileBloc.userProfile,
            profileRepository: profileBloc.profileRepository,
          )
            ..add(
              LoadAvailableEmojisStarted(),
            )
            ..add(
              LoadPersonalPhotosStarted(),
            ),
          child: const ChangeAvatarView(),
        );
      },
    ),
  );
}
