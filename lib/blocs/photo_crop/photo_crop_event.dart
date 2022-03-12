part of 'photo_crop_bloc.dart';

@immutable
abstract class PhotoCropEvent {}

abstract class PhotoCropStarted extends PhotoCropEvent {}

class PerformPhotoCropStarted extends PhotoCropStarted {
  final Uint8List photoBytes;

  final Rect section;

  final double rotation;

  PerformPhotoCropStarted({
    required final this.photoBytes,
    required final this.section,
    required final this.rotation,
  });
}

class CancelPhotoCropStarted extends PhotoCropStarted {}
