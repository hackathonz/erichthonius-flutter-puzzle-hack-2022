part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ValidateUsernameInitial extends ProfileState {}

class ValidateUsernameSuccess extends ProfileState {
  final bool isValid;

  ValidateUsernameSuccess({
    required final this.isValid,
  });
}

class ValidateUsernameFailure extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileFailure extends ProfileState {}

class AvatarChange extends ProfileState {
  final Avatar avatar;

  AvatarChange({
    required final this.avatar,
  });
}
