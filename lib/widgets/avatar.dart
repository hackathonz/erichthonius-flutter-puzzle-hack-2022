import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

class SwapItAvatar extends StatelessWidget {
  final Avatar avatar;

  final void Function()? onEditAvatarPressedCallback;

  final double _diameter;

  final TextStyle _emojiTextStyle;

  final Border? _border;

  const SwapItAvatar({
    Key? key,
    required final this.avatar,
    final this.onEditAvatarPressedCallback,
  })  : _diameter = kAvatarCircleDiameter,
        _emojiTextStyle = avatarEmojiTextStyle,
        _border = null,
        super(key: key);

  const SwapItAvatar.leaderboardTile({
    Key? key,
    required final this.avatar,
  })  : onEditAvatarPressedCallback = null,
        _diameter = kLeaderboardListTileAvatarCircleDiameter,
        _emojiTextStyle = leaderboardListTileAvatarEmojiTextStyle,
        _border = null,
        super(key: key);

  SwapItAvatar.leaderboardPanel({
    Key? key,
    required final this.avatar,
  })  : onEditAvatarPressedCallback = null,
        _diameter = kLeaderboardPanelAvatarCircleDiameter,
        _emojiTextStyle = leaderboardPanelAvatarEmojiTextStyle,
        _border = Border.all(
          color: leaderboardPanelAvatarBorderColor,
          style: BorderStyle.solid,
          width: 2.0,
        ),
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
              border: _border,
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
