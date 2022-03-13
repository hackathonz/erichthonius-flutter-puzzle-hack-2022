import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final Avatar avatar,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AvatarBloc(
                avatarRepository:
                    context.read<Vault>().lookup<AvatarRepository>(),
                avatar: avatar,
              )
                ..add(
                  LoadAvailableEmojisStarted(),
                )
                ..add(
                  LoadPersonalPhotosStarted(),
                ),
            ),
            BlocProvider(
              create: (context) => PhotoPickerBloc(
                imagePicker: context.read<Vault>().lookup<ImagePicker>(),
              ),
            ),
            BlocProvider.value(
              value: profileBloc,
            ),
          ],
          child: const ChangeAvatarView(),
        );
      },
    ),
  );
}

Future<void> navigateToPhotoCropView(
  final BuildContext context,
  final Uint8List photoBytes,
  final AvatarBloc avatarBloc,
) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PhotoCropBloc(
                photoBytes: photoBytes,
              ),
            ),
            BlocProvider.value(
              value: avatarBloc,
            ),
          ],
          child: const PhotoCropView(),
        );
      },
    ),
  );
}

Future<void> navigateToLeaderboardView(
  final BuildContext context,
  final LeaderboardBloc leaderboardBloc,
) {
  leaderboardBloc.add(
    LoadLeaderboardStarted(
      period: LeaderboardRankingPeriod.today,
    ),
  );

  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (routeContext) {
        return const LeaderboardView();
      },
    ),
  );
}
