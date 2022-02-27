import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

class ChooseLevelView extends StatelessWidget {
  const ChooseLevelView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const targetSize = Size(390.0, 844.0);

    final sourceSize = MediaQuery.of(context).size;

    final markers = [
      MapEntry(
        '1',
        Point(
          (sourceSize.width * 27.5) / targetSize.width,
          (sourceSize.height * 80.0) / targetSize.height,
        ),
      ),
      MapEntry(
        '2',
        Point(
          (sourceSize.width * 150.0) / targetSize.width,
          (sourceSize.height * 285.0) / targetSize.height,
        ),
      ),
      MapEntry(
        '3',
        Point(
          (sourceSize.width * 230.0) / targetSize.width,
          (sourceSize.height * 490.0) / targetSize.height,
        ),
      ),
      MapEntry(
        '4',
        Point(
          (sourceSize.width * 26.5) / targetSize.width,
          (sourceSize.height * 623.5) / targetSize.height,
        ),
      ),
      MapEntry(
        '5',
        Point(
          (sourceSize.width * 178.5) / targetSize.width,
          (sourceSize.height * 780.5) / targetSize.height,
        ),
      ),
    ];

    return SwapItScaffold(
      appBar: SwapItAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const EasyMap(),
              ...markers.map(
                (x) => Positioned(
                  bottom: x.value.y,
                  right: x.value.x,
                  child: LevelMarker(
                    level: GameLevel(
                      difficulty: LevelDifficulty.easy,
                      id: x.key,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
