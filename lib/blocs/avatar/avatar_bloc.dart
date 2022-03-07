import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/data/data.dart';
import 'package:swap_it/models/models.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final ProfileRepository profileRepository;

  final UserProfile userProfile;

  AvatarBloc({
    required final this.profileRepository,
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
    yield LoadAvailableEmojisSuccess(
      emojis: const [
        '😎',
        '🎃',
        '❤️',
        '👻',
        '😇',
        '🚀',
        '🚘',
        '🤔',
        '🙈',
        '😈',
        '👀',
        '🧩',
      ],
      selectedEmoji: '😎',
    );
  }

  Stream<AvatarState> _mapLoadPersonalPhotosStartedToState(
    LoadPersonalPhotosStarted event,
  ) async* {
    yield LoadPersonalPhotosSuccess(
      urls: const [
        'https://lh3.googleusercontent.com/a-/AOh14GgDn_JFNit9gPzQNfeV8I-yB28qKK1fGPfoFg=s256'
      ],
    );
  }
}
