import 'package:flutter/material.dart';

class PictureTile {
  final int id;

  final ImageProvider? imageProvider;

  bool get isEmpty => imageProvider == null;

  const PictureTile({
    required final this.id,
    required final this.imageProvider,
  });

  const PictureTile.empty({
    required final this.id,
  }) : imageProvider = null;
}
