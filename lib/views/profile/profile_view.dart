import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/scaffold.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppBarPaddingBetweenAvatarAndUsername = EdgeInsets.symmetric(
  vertical: 6.0,
);

const _kAppBarPaddingBetweenUsernameAndDateJoined = EdgeInsets.symmetric(
  vertical: 3.0,
);

const _kAppBarPaddingBetweenDateJoinedAndUsernameForm = EdgeInsets.symmetric(
  vertical: 16.0,
);

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final gameBloc = context.read<GameBloc>();

    final userProfile = gameBloc.game.gameUserProfile.profile;

    return SwapItScaffold(
      appBar: SwapItAppBar(
        title: localizations.profileDetailsTitle,
      ),
      scaffoldPadding: kProfileViewsPadding,
      body: Center(
        child: ListView(
          children: [
            SwapItAvatar(
              avatar: userProfile.avatar,
              onEditAvatarPressedCallback: () {},
            ),
            const Padding(
              padding: _kAppBarPaddingBetweenAvatarAndUsername,
            ),
            Text(
              userProfile.username,
              style: profileUsernameTextStyle,
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: _kAppBarPaddingBetweenUsernameAndDateJoined,
            ),
            Text(
              localizations.profileDateJoined(
                userProfile.dateJoined,
              ),
              style: profileDateJoinedTextStyle,
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: _kAppBarPaddingBetweenDateJoinedAndUsernameForm,
            ),
            SwapItTextFormInput(
              controller: TextEditingController(
                text: userProfile.username,
              ),
              label: localizations.username,
              validator: (p0) => null,
            ),
          ],
          primary: false,
        ),
      ),
      bottomButton: SwapItButton(
        text: localizations.saveProfile,
        onPressed: () {},
      ),
    );
  }
}
