part of 'avatar_bloc.dart';

@immutable
abstract class AvatarEvent {}

class LoadAvailableEmojisStarted extends AvatarEvent {}

class LoadPersonalPhotosStarted extends AvatarEvent {}

class EmojiSelected extends AvatarEvent {
  final String emoji;

  EmojiSelected({
    required final this.emoji,
  });
}

class PersonalPhotoSelected extends AvatarEvent {
  final String photoUrl;

  PersonalPhotoSelected({
    required final this.photoUrl,
  });
}

class ChangeAvatarStarted extends AvatarEvent {}
