part of 'avatar_bloc.dart';

@immutable
abstract class AvatarState {}

class AvatarInitial extends AvatarState {}

class LoadAvailableEmojisSuccess extends AvatarState {
  final List<String> emojis;

  final String? selectedEmoji;

  LoadAvailableEmojisSuccess({
    required final this.emojis,
    final this.selectedEmoji,
  });
}

class LoadPersonalPhotosSuccess extends AvatarState {
  final List<String> urls;

  final String? selectedPhotoUrl;

  LoadPersonalPhotosSuccess({
    required final this.urls,
    final this.selectedPhotoUrl,
  });
}

class LoadPersonalPhotosFailure extends AvatarState {}

class AvatarUpdate extends AvatarState {
  final Avatar avatar;

  final bool markedAsChangeAvatar;

  AvatarUpdate({
    required final this.avatar,
    final this.markedAsChangeAvatar = false,
  });
}
