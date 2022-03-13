import 'package:flutter/material.dart';
import 'package:swap_it/models/models.dart';

const backgroundGradient = RadialGradient(
  colors: [
    Color(0xFF4448E8),
    Color(0xFF6063F2),
  ],
  stops: [0.0, 1.0],
);

const backgroundDecoration = BoxDecoration(
  gradient: backgroundGradient,
);

const iconsColor = Color(0xFFFFFFFF);
const iconBaseColor = Color(0xFF4447CA);
const iconBaseAlternativeColor = Color(0xFFEBCD17);
const iconStarColor = Color(0xFFFCD261);
const iconStarGrayColor = Color(0xFFEEEEEE);

const primaryTextColor = Color(0xFFFFFFFF);
const primaryLightTextColor = Color(0xFFDDDDDD);
const alternativeTextColor = Color(0xFF333333);
const alertTextColor = Color(0xFFFA4C2B);
const primaryButtonColor = Color(0xFF4447CA);
const primaryTextButtonColor = Color(0xFF4447CA);
const primaryCardColor = Color(0xFF4447CA);
const primaryCardShadowColor = Color(0x20000000);
const dialogTextColor = Color(0xFF4447CA);
const dialogBackgroundColor = Color(0xFFFFFFFF);
const dialogBarrierColor = Color(0x449C9C9C);
const alternativeButtonColor = Color(0xFFFFFFFF);
const alternativeButtonTextColor = Color(0xFF4447CA);
const alternativeButtonBorderColor = Color(0xFF4447CA);
const avatarBackgroundColor = Color(0xFFD2D3FF);
const inputDecorationBorderColor = Color(0xFF4447CA);
const inputDecorationErrorBorderColor = Color(0xFFFA4C2B);
const inputDecorationFillColor = Color(0x664447CA);
const inputDecorationErrorFillColor = Color(0x1FFA4C2B);
const inputDecorationTextColor = Color(0xFFFFFFFF);
const inputDecorationHintTextColor = Color(0xB8FFFFFF);
const inputDecorationErrorTextColor = Color(0xFFFA4C2B);
const primaryGridTileColor = Color(0x664447CA);
const alternativeGridTileColor = Color(0xFFD2D3FF);
const primaryGridTileBorderColor = Color(0xFF4447CA);
const alternativeGridTileBorderColor = Color(0xFFFFFFFF);
const cropViewCornerColor = Color(0xFFFFFFFF);
const cropViewMaskColorDisabled = Color(0x33FFFFFF);
const cropViewMaskColorPressed = Color(0x66FFFFFF);
const cropViewBackgroundColor = Color(0xFF000000);
const cropViewActionsBaseColor = Color(0xFFFFFFFF);
const activeTabColor = Color(0xFFFFFFFF);
const inactiveTabColor = Color(0xFF4447CA);
const activeTabLabelColor = Color(0xFF4447CA);
const inactiveTabLabelColor = Color(0xFFFFFFFF);
const tabBarColor = Color(0xFF4447CA);
const leaderboardViewBackgroundColor = Color(0xFFFFFFFF);
const leaderboardListTileTextColor = Color(0xFF333333);
const leaderboardListTilePointsColor = Color(0xFF4447CA);
const leaderboardPanelAvatarBorderColor = Color(0xFF4447CA);
const leaderboardPanelUsernameColor = Color(0xCCFFFFFF);
const leaderboardPanelPointsColor = Color(0xFFFFFFFF);

const kListTileColor = Color(0xFF4447CA);
const kLeaderboardListTileColor = Color(0xFFF8F8F8);

final transparentMaterialState = MaterialStateProperty.all(Colors.transparent);

const listTileBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
  offset: Offset(0.0, 2.0),
  blurRadius: 20.0,
);

const levelMarkerBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
  offset: Offset(0.0, 2.0),
  blurRadius: 22.0,
);

const switchActiveColor = Color(0x66D2D3FF);
const switchTrackColor = Color(0x66000000);

const easyLevelMarkerColor = Color(0xFF7ED5DD);
const mediumLevelMarkerColor = Color(0xFFE8E768);
const hardLevelMarkerColor = Color(0xFFE7B277);

const levelMarkerBorderColor = Color(0xFFFFFFFF);

Color mapColorForDifficulty(final LevelDifficulty difficulty) {
  switch (difficulty) {
    case LevelDifficulty.easy:
      return easyLevelMarkerColor;
    case LevelDifficulty.medium:
      return mediumLevelMarkerColor;
    case LevelDifficulty.hard:
      return hardLevelMarkerColor;
  }
}
