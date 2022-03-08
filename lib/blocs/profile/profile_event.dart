part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ValidateUsernameStarted extends ProfileEvent {
  final String newUsername;

  ValidateUsernameStarted({
    required final this.newUsername,
  });
}

class UpdateProfileStarted extends ProfileEvent {
  final String newUsername;

  UpdateProfileStarted({
    required final this.newUsername,
  });
}

class UsernameReset extends ProfileEvent {}

class AvatarChanged extends ProfileEvent {
  final Avatar avatar;

  AvatarChanged({
    required final this.avatar,
  });
}
