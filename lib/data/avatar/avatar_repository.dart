const defaultAvailableEmojis = [
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
];

abstract class AvatarRepository {
  Future<List<String>> availableEmojis();

  Future<List<String>> personalPhotos();
}

class RealAvatarRepository extends AvatarRepository {
  @override
  Future<List<String>> availableEmojis() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> personalPhotos() {
    throw UnimplementedError();
  }
}

class MockAvatarRepository extends AvatarRepository {
  final _personalPhotos = [
    'https://bk.ibxk.com.br/2015/6/programas/76091895.png',
  ];

  @override
  Future<List<String>> availableEmojis() {
    return Future.value(defaultAvailableEmojis);
  }

  @override
  Future<List<String>> personalPhotos() {
    return Future.value(_personalPhotos);
  }
}
