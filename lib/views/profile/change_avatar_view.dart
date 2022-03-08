import 'package:flutter/material.dart' hide GridTile;
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/scaffold.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppBarPaddingBetweenAvatarAndEmojisGrid = EdgeInsets.symmetric(
  vertical: 24.0,
);

const _kAppBarPaddingBetweenEmojisGridAndPPhotosGrid = EdgeInsets.symmetric(
  vertical: 14.0,
);

class ChangeAvatarView extends StatelessWidget {
  const ChangeAvatarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final profileBloc = context.read<AvatarBloc>();

    final userProfile = profileBloc.userProfile;

    return SwapItScaffold(
      appBar: SwapItAppBar(
        title: localizations.changeAvatarTitle,
        showLeading: false,
        showTrailing: true,
      ),
      scaffoldPadding: kProfileViewsPadding,
      body: Center(
        child: ListView(
          children: [
            SwapItAvatar(
              avatar: userProfile.avatar,
            ),
            const Padding(
              padding: _kAppBarPaddingBetweenAvatarAndEmojisGrid,
            ),
            BlocBuilder<AvatarBloc, AvatarState>(
              buildWhen: (previous, current) =>
                  current is LoadAvailableEmojisSuccess,
              builder: (context, state) {
                return Grid(
                  label: localizations.emojis,
                  tiles: [
                    if (state is LoadAvailableEmojisSuccess)
                      ...state.emojis.map(
                        (x) => GridTile(
                          data: EmojiGridTileData(
                            emojiText: x,
                          ),
                          isSelected: x == state.selectedEmoji,
                          onPressed: () {},
                        ),
                      ),
                  ],
                );
              },
            ),
            const Padding(
              padding: _kAppBarPaddingBetweenEmojisGridAndPPhotosGrid,
            ),
            BlocBuilder<AvatarBloc, AvatarState>(
              buildWhen: (previous, current) =>
                  current is LoadPersonalPhotosSuccess,
              builder: (context, state) {
                if (state is LoadPersonalPhotosSuccess) {
                  return Grid(
                    label: localizations.personalPhotos,
                    tiles: [
                      ...state.urls.map(
                        (x) => GridTile(
                          data: PhotoGridTileData(
                            url: x,
                          ),
                          isSelected: x == state.selectedPhotoUrl,
                          onPressed: () {},
                        ),
                      ),
                      GridTile(
                        data: IconGridTileData(
                          iconData: SwapItIcons.add,
                        ),
                        isSelected: false,
                        onPressed: () {},
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
          primary: false,
        ),
      ),
      bottomButton: SwapItButton(
        text: localizations.changeAvatar,
        onPressed: () {},
      ),
    );
  }
}
