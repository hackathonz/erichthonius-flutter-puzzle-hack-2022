part of 'photo_picker_bloc.dart';

@immutable
abstract class PhotoPickerState {}

class PhotoPickerInitial extends PhotoPickerState {}

class PickPhotoSuccess extends PhotoPickerState {
  final Uint8List bytes;

  PickPhotoSuccess({
    required final this.bytes,
  });
}

class PickPhotoFailure extends PhotoPickerState {}

class NoPermissionsPickPhotoFailure extends PhotoPickerState {}
