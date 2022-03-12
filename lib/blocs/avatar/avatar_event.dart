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

abstract class PersonalPhotoSelected extends AvatarEvent {}

class ExistingPersonalPhotoSelected extends PersonalPhotoSelected {
  final String photoUrl;

  ExistingPersonalPhotoSelected({
    required final this.photoUrl,
  });
}

class NewPersonalPhotoSelected extends PersonalPhotoSelected {
  final Uint8List photoBytes;

  NewPersonalPhotoSelected({
    required final this.photoBytes,
  });
}

class ChangeAvatarStarted extends AvatarEvent {}
