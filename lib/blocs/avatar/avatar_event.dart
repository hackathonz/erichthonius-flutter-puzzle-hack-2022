part of 'avatar_bloc.dart';

@immutable
abstract class AvatarEvent {}

class LoadAvailableEmojisStarted extends AvatarEvent {}

class LoadPersonalPhotosStarted extends AvatarEvent {}
