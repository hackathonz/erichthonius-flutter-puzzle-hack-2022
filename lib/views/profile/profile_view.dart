import 'package:flutter/material.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/routing/routing.dart';
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

    final profileBloc = context.read<ProfileBloc>();

    final userProfile = profileBloc.userProfile;

    final usernameTextEditingController = TextEditingController(
      text: userProfile.username,
    );

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
              onEditAvatarPressedCallback: () => navigateToChangeAvatarView(
                context,
                profileBloc,
              ),
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
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) =>
                  current is ValidateUsernameSuccess ||
                  current is ValidateUsernameInitial,
              builder: (context, state) {
                String? errorText;

                if (state is ValidateUsernameSuccess && !state.isValid) {
                  errorText = localizations.usernameAlreadyUsed;
                } else if (state is ValidateUsernameInitial) {
                  usernameTextEditingController.text = userProfile.username;
                }

                return SwapItTextFormInput(
                  controller: usernameTextEditingController,
                  label: localizations.username,
                  errorText: errorText,
                  showTrailingIcon: errorText != null,
                  onTrailingIconPressed: () {
                    profileBloc.add(
                      UsernameReset(),
                    );
                  },
                  onChanged: (username) {
                    profileBloc.add(
                      ValidateUsernameStarted(
                        newUsername: username,
                      ),
                    );
                  },
                );
              },
            ),
          ],
          primary: false,
        ),
      ),
      bottomButton: SwapItButton(
        text: localizations.saveProfile,
        onPressed: () {
          profileBloc.add(
            UpdateProfileStarted(
              newUsername: usernameTextEditingController.text,
            ),
          );
        },
      ),
    );
  }
}
