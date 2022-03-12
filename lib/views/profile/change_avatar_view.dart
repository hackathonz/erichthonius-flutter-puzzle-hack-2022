import 'package:flutter/material.dart' hide GridTile;
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/routing/routing.dart';
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

    final avatarBloc = context.read<AvatarBloc>();

    final photoPickerBloc = context.read<PhotoPickerBloc>();

    final profileBloc = context.read<ProfileBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<AvatarBloc, AvatarState>(
          listenWhen: (previous, current) =>
              current is AvatarUpdate && current.markedAsChangeAvatar,
          listener: (context, state) {
            if (state is AvatarUpdate) {
              _onAvatarUpdateStateReact(state, profileBloc);
            }
          },
        ),
        BlocListener<PhotoPickerBloc, PhotoPickerState>(
          listener: (context, state) {
            if (state is PickPhotoSuccess) {
              _onPickPhotoSuccessStateReact(context, state);
            }
          },
        ),
      ],
      child: SwapItScaffold(
        appBar: SwapItAppBar(
          title: localizations.changeAvatarTitle,
          showLeading: false,
          showTrailing: true,
        ),
        scaffoldPadding: kProfileViewsPadding,
        body: Center(
          child: ListView(
            children: [
              BlocBuilder<AvatarBloc, AvatarState>(
                buildWhen: (previous, current) => current is AvatarUpdate,
                builder: (context, state) {
                  return SwapItAvatar(
                    avatar: state is AvatarUpdate
                        ? state.avatar
                        : avatarBloc.avatar,
                  );
                },
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
                            onPressed: () => avatarBloc.add(
                              EmojiSelected(
                                emoji: x,
                              ),
                            ),
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
                            onPressed: () => avatarBloc.add(
                              PersonalPhotoSelected(
                                photoUrl: x,
                              ),
                            ),
                          ),
                        ),
                        GridTile(
                          data: IconGridTileData(
                            iconData: SwapItIcons.add,
                          ),
                          isSelected: false,
                          onPressed: () {
                            photoPickerBloc.add(
                              PickPhotoStarted(),
                            );
                          },
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
          onPressed: () {
            avatarBloc.add(
              ChangeAvatarStarted(),
            );
          },
        ),
      ),
    );
  }

  void _onAvatarUpdateStateReact(
    final AvatarUpdate state,
    final ProfileBloc profileBloc,
  ) {
    profileBloc.add(
      AvatarChanged(
        avatar: state.avatar,
      ),
    );
  }

  void _onPickPhotoSuccessStateReact(
    final BuildContext context,
    final PickPhotoSuccess state,
  ) {
    navigateToPhotoCropView(context, state.bytes);
  }
}
