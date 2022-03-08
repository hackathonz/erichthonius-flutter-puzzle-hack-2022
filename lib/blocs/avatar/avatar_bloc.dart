import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final AvatarRepository avatarRepository;

  final UserProfile userProfile;

  AvatarBloc({
    required final this.avatarRepository,
    required final this.userProfile,
  }) : super(AvatarInitial());

  @override
  Stream<AvatarState> mapEventToState(AvatarEvent event) async* {
    if (event is LoadAvailableEmojisStarted) {
      yield* _mapLoadAvailableEmojisStartedToState(event);
    } else if (event is LoadPersonalPhotosStarted) {
      yield* _mapLoadPersonalPhotosStartedToState(event);
    }
  }

  Stream<AvatarState> _mapLoadAvailableEmojisStartedToState(
    LoadAvailableEmojisStarted event,
  ) async* {
    try {
      final emojis = await avatarRepository.availableEmojis();

      yield LoadAvailableEmojisSuccess(
        emojis: emojis,
        selectedEmoji: userProfile.avatar.data,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield LoadAvailableEmojisSuccess(
        emojis: defaultAvailableEmojis,
      );
    }
  }

  Stream<AvatarState> _mapLoadPersonalPhotosStartedToState(
    LoadPersonalPhotosStarted event,
  ) async* {
    try {
      final photosUrls = await avatarRepository.personalPhotos();

      yield LoadPersonalPhotosSuccess(
        urls: photosUrls,
        selectedPhotoUrl: userProfile.avatar.data,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield LoadPersonalPhotosFailure();
    }
  }
}
