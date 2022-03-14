import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart';
import 'package:swap_it/logging/logging.dart';

part 'photo_crop_event.dart';
part 'photo_crop_state.dart';

class PhotoCropBloc extends Bloc<PhotoCropEvent, PhotoCropState> {
  final Uint8List photoBytes;

  PhotoCropBloc({
    required final this.photoBytes,
  }) : super(PhotoCropInitial());

  @override
  Stream<PhotoCropState> mapEventToState(PhotoCropEvent event) async* {
    if (event is PhotoCropStarted) {
      yield* _mapPhotoCropStartedToState(event);
    }
  }

  Stream<PhotoCropState> _mapPhotoCropStartedToState(
    PhotoCropStarted event,
  ) async* {
    if (event is PerformPhotoCropStarted) {
      try {
        final decoder = findDecoderForData(event.photoBytes);

        final image = decoder?.decodeImage(event.photoBytes);

        if (image != null) {
          final croppedAndRotatedImage = copyRotate(
            copyCrop(
              image,
              event.section.left.toInt(),
              event.section.top.toInt(),
              event.section.width.toInt(),
              event.section.height.toInt(),
            ),
            event.rotation,
          );

          final croppedAndRotatedImageBytes = _encodeImage(
            decoder!,
            croppedAndRotatedImage,
          );

          yield PhotoCropSuccess(
            photoBytes: Uint8List.fromList(
              croppedAndRotatedImageBytes,
            ),
          );
        } else {
          yield PhotoCropFailure();
        }
      } on Object catch (error, stacktrace) {
        logError(error, stacktrace: stacktrace);

        yield PhotoCropFailure();
      }
    } else {
      yield PhotoCropCancel();
    }
  }

  Uint8List _encodeImage(
    final Decoder decoder,
    final Image image,
  ) {
    late List<int> bytes;

    switch (decoder.runtimeType) {
      case PngDecoder:
        bytes = encodePng(image);
        break;
      case TgaDecoder:
        bytes = encodeTga(image);
        break;
      case BmpDecoder:
        bytes = encodeBmp(image);
        break;
      case GifDecoder:
        bytes = encodeGif(image);
        break;
      case JpegDecoder:
      default:
        bytes = encodeJpg(image);
        break;
    }

    return Uint8List.fromList(bytes);
  }
}
