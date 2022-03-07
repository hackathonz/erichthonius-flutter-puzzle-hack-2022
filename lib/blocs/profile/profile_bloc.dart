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
    try {
      if (event.newUsername == userProfile.username) {
        yield ValidateUsernameInitial();
      } else {
        final validation = await profileRepository.validateUsername(
          event.newUsername,
        );

        yield ValidateUsernameSuccess(isValid: validation);
      }
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield ValidateUsernameFailure();
    }
  }

  Stream<ProfileState> _mapUpdateProfileStartedToState(
    UpdateProfileStarted event,
  ) async* {
    yield UpdateProfileSuccess();
  }

  Stream<ProfileState> _mapUsernameResetToState(
    UsernameReset event,
  ) async* {
    yield ValidateUsernameInitial();
  }
}
