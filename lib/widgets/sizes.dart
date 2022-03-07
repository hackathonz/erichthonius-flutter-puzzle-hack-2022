import 'package:flutter/material.dart';
import 'package:swap_it/models/level.dart';
import 'package:swap_it/widgets/widgets.dart';

const kIconBaseDiameter = 48.0;
const kIconBaseAlternativeDiameter = 56.0;
const kIconBaseAvatarEditDiameter = 32.0;
const kIconPrimarySize = 32.0;
const kIconAlternativeSize = 40.0;
const kIconAvatarEditSize = 24.0;
const kIconAppBarSize = 24.0;
const kIconAppBarTitleSize = 16.0;
const kIconLevelMarkerSize = 48.0;
const kIconGameFinishDialogStarSize = 48.0;
const kCardRadius = 8.0;
const kDialogRadius = 18.0;
const kInputDecorationBorderRadius = 8.0;
const kListTileRadius = 8.0;
const kCardElevation = 2.0;
const kBottomNavigationBarElevation = 0.0;
const kAppBarElevation = 0.0;
const kCardSize = Size(327.0, 144.0);
const kListTileSize = Size(327.0, 48.0);
const kLevelMarkerSize = Size.square(64.0);
const kSwitchWidth = 60.0;
const kSwitchToggleSize = 24.0;
const kLevelMarkerRadius = 64.0;
const kLevelMarkerBorderThickness = 4.0;
const kEasyPictureTileSize = Size.square(99.0);
const kMediumPictureTileSize = Size.square(72.0);
const kHardPictureTileSize = Size.square(56.0);
const kPictureTileRadius = 8.04;
const kEasyPuzzleGameTileCount = 9;
const kMediumPuzzleGameTileCount = 16;
const kHardPuzzleGameTileCount = 25;
const kPuzzleGameTilesSpacing = 13.0;
const kDialogElevation = 24.0;
const kAvatarCircleDiameter = 112.0;

const iconThemeData = IconThemeData(
  color: iconsColor,
  size: kIconPrimarySize,
);

const appBarIconThemeData = IconThemeData(
  color: iconsColor,
  size: kIconAppBarSize,
);

const kScaffoldPadding = EdgeInsets.symmetric(
  horizontal: 24.0,
);

const kGameLevelPadding = EdgeInsets.symmetric(
  vertical: 24.0,
);

const kDialogTitlePadding = EdgeInsets.only(
  top: 40.0,
);

const kDialogContentPadding = EdgeInsets.only(
  left: 40.0,
  right: 40.0,
  bottom: 35.0,
);

const kProfileViewsPadding = EdgeInsets.symmetric(
  vertical: 24.0,
  horizontal: 24.0,
);

const inputDecorationBorderSide = BorderSide(
  color: inputDecorationBorderColor,
  style: BorderStyle.solid,
  width: 1.0,
);

const inputDecorationErrorBorderSide = BorderSide(
  color: inputDecorationErrorBorderColor,
  style: BorderStyle.solid,
  width: 1.0,
);

Size mapPictureTileSizeForDifficulty(
  final LevelDifficulty difficulty,
) {
  switch (difficulty) {
    case LevelDifficulty.easy:
      return kEasyPictureTileSize;
    case LevelDifficulty.medium:
      return kMediumPictureTileSize;
    case LevelDifficulty.hard:
    default:
      return kHardPictureTileSize;
  }
}

int mapPuzzleGameTileCountForDifficulty(
  final LevelDifficulty difficulty,
) {
  switch (difficulty) {
    case LevelDifficulty.easy:
      return kEasyPuzzleGameTileCount;
    case LevelDifficulty.medium:
      return kMediumPuzzleGameTileCount;
    case LevelDifficulty.hard:
    default:
      return kHardPuzzleGameTileCount;
  }
}
