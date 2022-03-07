import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/scaffold.dart';
import 'package:swap_it/widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final gameBloc = context.read<GameBloc>();

    return SwapItScaffold(
      appBar: SwapItAppBar(
        title: localizations.profileDetailsTitle,
      ),
      body: Center(
        child: ListView(
          children: [
            SwapItAvatar(
              avatar: gameBloc.game.gameUserProfile.profile.avatar,
              onEditAvatarPressedCallback: () {},
            ),
          ],
        ),
      ),
      bottomButton: SwapItButton(
        text: localizations.saveProfile,
        onPressed: () {},
      ),
    );
  }
}
