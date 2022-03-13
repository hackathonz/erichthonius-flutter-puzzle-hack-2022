import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

class SwapItAvatar extends StatelessWidget {
  final Avatar avatar;

  final void Function()? onEditAvatarPressedCallback;

  final double _diameter;

  final TextStyle _emojiTextStyle;

  const SwapItAvatar({
    Key? key,
    required final this.avatar,
    final this.onEditAvatarPressedCallback,
  })  : _diameter = kAvatarCircleDiameter,
        _emojiTextStyle = avatarEmojiTextStyle,
        super(key: key);

  const SwapItAvatar.leaderboardTile({
    Key? key,
    required final this.avatar,
    final this.onEditAvatarPressedCallback,
  })  : _diameter = kLeaderboardListTileAvatarCircleDiameter,
        _emojiTextStyle = leaderboardListTileAvatarEmojiTextStyle,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            width: _diameter,
            height: _diameter,
            child: ClipOval(
              child: Center(
                child: !avatar.isUrl
                    ? Text(
                        avatar.data,
                        style: _emojiTextStyle,
                        textAlign: TextAlign.center,
                      )
                    : null,
              ),
            ),
            decoration: BoxDecoration(
              color: avatarBackgroundColor,
              shape: BoxShape.circle,
              image: avatar.isUrl
                  ? DecorationImage(
                      image: NetworkImage(avatar.data),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          if (onEditAvatarPressedCallback != null)
            Positioned(
              bottom: 0,
              right: _diameter,
              child: IconBase(
                key: const Key('avatar_edit_icon'),
                child: const Icon(
                  SwapItIcons.pencil,
                  size: kIconAvatarEditSize,
                ),
                onPressed: onEditAvatarPressedCallback!,
                diameter: kIconBaseAvatarEditDiameter,
              ),
            ),
        ],
        alignment: Alignment.center,
      ),
      onTap: onEditAvatarPressedCallback,
      behavior: HitTestBehavior.translucent,
    );
  }
}
