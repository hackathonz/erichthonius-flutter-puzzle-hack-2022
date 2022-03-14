import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<String> uploadPhoto(final Uint8List bytes);
}

class RealAvatarRepository extends AvatarRepository {
  final FirebaseStorage storage;

  final String deviceId;

  RealAvatarRepository({
    required final this.deviceId,
    required final this.storage,
  });

  @override
  Future<List<String>> availableEmojis() {
    return Future.value(defaultAvailableEmojis);
  }

  @override
  Future<List<String>> personalPhotos() async {
    final results = await storage.ref(deviceId).child('photos').listAll();

    final photos = <String>[];

    for (var x in results.items) {
      photos.add(
        await x.getDownloadURL(),
      );
    }

    return photos;
  }

  @override
  Future<String> uploadPhoto(Uint8List bytes) async {
    final photosRef = storage
        .ref(deviceId)
        .child('photos/${DateTime.now().millisecondsSinceEpoch}');

    await photosRef.putData(bytes);

    return await photosRef.getDownloadURL();
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

  @override
  Future<String> uploadPhoto(Uint8List bytes) {
    return Future.value(_personalPhotos.first);
  }
}
