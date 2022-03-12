import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:swap_it/logging/logging.dart';

part 'photo_picker_event.dart';
part 'photo_picker_state.dart';

class PhotoPickerBloc extends Bloc<PhotoPickerEvent, PhotoPickerState> {
  final ImagePicker imagePicker;

  PhotoPickerBloc({
    required final this.imagePicker,
  }) : super(PhotoPickerInitial());

  @override
  Stream<PhotoPickerState> mapEventToState(PhotoPickerEvent event) async* {
    if (event is PickPhotoStarted) {
      yield* _mapPickPhotoStartedToState(event);
    }
  }

  Stream<PhotoPickerState> _mapPickPhotoStartedToState(
    PickPhotoStarted event,
  ) async* {
    try {
      final photoFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (photoFile != null) {
        yield PickPhotoSuccess(
          bytes: await photoFile.readAsBytes(),
        );
      } else {
        yield PickPhotoFailure();
      }
    } on Object catch (error, stacktrace) {
      logError(error, stacktrace: stacktrace);

      yield error is PlatformException
          ? NoPermissionsPickPhotoFailure()
          : PickPhotoFailure();
    }
  }
}
