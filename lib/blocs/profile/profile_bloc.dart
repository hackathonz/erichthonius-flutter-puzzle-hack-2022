import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  final UserProfile userProfile;

  ProfileBloc({
    required final this.profileRepository,
    required final this.userProfile,
  }) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ValidateUsernameStarted) {
      yield* _mapValidateUsernameStartedToState(event);
    } else if (event is UpdateProfileStarted) {
      yield* _mapUpdateProfileStartedToState(event);
    } else if (event is UsernameReset) {
      yield* _mapUsernameResetToState(event);
    }
  }

  Stream<ProfileState> _mapValidateUsernameStartedToState(
    ValidateUsernameStarted event,
  ) async* {
    yield await _mapUsernameValidationCallToState(event.newUsername);
  }

  Stream<ProfileState> _mapUpdateProfileStartedToState(
    UpdateProfileStarted event,
  ) async* {
    try {
      final validationState = await _mapUsernameValidationCallToState(
        event.newUsername,
      );

      if (validationState is ValidateUsernameSuccess &&
          validationState.isValid) {
        profileRepository.updateProfile(
          userProfile.copyWith(
            username: event.newUsername,
          ),
        );

        yield UpdateProfileSuccess();
      } else {
        yield validationState;
      }
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield UpdateProfileFailure();
    }
  }

  Stream<ProfileState> _mapUsernameResetToState(
    UsernameReset event,
  ) async* {
    yield ValidateUsernameInitial();
  }

  Future<ProfileState> _mapUsernameValidationCallToState(
    final String newUsername,
  ) async {
    try {
      if (newUsername == userProfile.username) {
        return ValidateUsernameInitial();
      } else {
        final validation = await profileRepository.validateUsername(
          newUsername,
        );

        return ValidateUsernameSuccess(isValid: validation);
      }
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      return ValidateUsernameFailure();
    }
  }
}
