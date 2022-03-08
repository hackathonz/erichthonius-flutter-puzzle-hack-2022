import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/blocs/blocs.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/logging/logging.dart';
import 'package:swap_it/models/models.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final AvatarRepository avatarRepository;

  final UserProfile userProfile;

  String? selectedPhotoUrl;

  String? selectedEmoji;

  late final List<String> _availableEmojis;

  late final List<String> _personalPhotos;

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
    } else if (event is EmojiSelected) {
      yield* _mapEmojiSelectedToState(event);
    } else if (event is PersonalPhotoSelected) {
      yield* _mapPersonalPhotoSelectedToState(event);
    }
  }

  Stream<AvatarState> _mapLoadAvailableEmojisStartedToState(
    LoadAvailableEmojisStarted event,
  ) async* {
    try {
      final emojis = await avatarRepository.availableEmojis();

      _availableEmojis = emojis;

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

      _personalPhotos = photosUrls;

      yield LoadPersonalPhotosSuccess(
        urls: _personalPhotos,
        selectedPhotoUrl: userProfile.avatar.data,
      );
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield LoadPersonalPhotosFailure();
    }
  }

  Stream<AvatarState> _mapEmojiSelectedToState(
    EmojiSelected event,
  ) async* {
    selectedEmoji = event.emoji;

    yield LoadAvailableEmojisSuccess(
      emojis: _availableEmojis,
      selectedEmoji: selectedEmoji,
    );

    yield AvatarUpdate(
      avatar: Avatar(
        data: selectedEmoji!,
        isUrl: false,
      ),
    );

    yield LoadPersonalPhotosSuccess(
      urls: _personalPhotos,
    );
  }

  Stream<AvatarState> _mapPersonalPhotoSelectedToState(
    PersonalPhotoSelected event,
  ) async* {
    selectedPhotoUrl = event.photoUrl;

    yield LoadPersonalPhotosSuccess(
      urls: _personalPhotos,
      selectedPhotoUrl: selectedPhotoUrl,
    );

    yield AvatarUpdate(
      avatar: Avatar(
        data: selectedPhotoUrl!,
        isUrl: true,
      ),
    );

    yield LoadAvailableEmojisSuccess(
      emojis: _availableEmojis,
    );
  }
}
