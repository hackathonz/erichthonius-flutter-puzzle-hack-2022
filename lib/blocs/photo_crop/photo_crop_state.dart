part of 'photo_crop_bloc.dart';

@immutable
abstract class PhotoCropState {}

class PhotoCropInitial extends PhotoCropState {}

class PhotoCropSuccess extends PhotoCropState {
  final Uint8List photoBytes;

  PhotoCropSuccess({
    required final this.photoBytes,
  });
}

class PhotoCropFailure extends PhotoCropState {}

class PhotoCropCancel extends PhotoCropState {}
