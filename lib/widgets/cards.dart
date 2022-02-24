import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/models/models.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kCardContentPadding = EdgeInsets.symmetric(
  horizontal: 24.0,
);

const _kCardTitleAndSubtitlePadding = EdgeInsets.symmetric(
  vertical: 8.0,
);

class GameLevelDifficultyCard extends StatelessWidget {
  final GameLevelDifficulty gameLevelDifficulty;

  const GameLevelDifficultyCard({
    Key? key,
    required final this.gameLevelDifficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SizedBox.fromSize(
      size: kCardSize,
      child: Card(
        child: Padding(
          padding: _kCardContentPadding,
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    localizations.difficulty(
                      gameLevelDifficulty.difficulty,
                    ),
                    style: gameLevelDifficultyCardTitleTextStyle,
                    textAlign: TextAlign.left,
                  ),
                  const Padding(
                    padding: _kCardTitleAndSubtitlePadding,
                  ),
                  Text(
                    localizations.piecesCount(
                      gameLevelDifficulty.pieces,
                    ),
                    style: gameLevelDifficultyCardSubtitleTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              mapPreviewForDifficulty(
                gameLevelDifficulty.difficulty,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}


// return Container(
//       width: 327,
//       height: 144,
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//               top: 0,
//               left: 0,
//               child: Container(
//                   width: 327,
//                   height: 144,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8),
//                       bottomLeft: Radius.circular(8),
//                       bottomRight: Radius.circular(8),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
//                           offset: Offset(0, 2),
//                           blurRadius: 20)
//                     ],
//                     color: Color.fromRGBO(68, 71, 202, 1),
//                   ))),
//           Positioned(
//               top: 40,
//               left: 24,
//               child: Container(
//                   width: 68,
//                   height: 64,
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                   child: Stack(children: <Widget>[
//                     Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Text(
//                           'Easy',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Color.fromRGBO(255, 255, 255, 1),
//                               fontFamily: 'Poppins',
//                               fontSize: 24,
//                               letterSpacing: 0,
//                               fontWeight: FontWeight.normal,
//                               height: 1),
//                         )),
//                     Positioned(
//                         top: 41,
//                         left: 0,
//                         child: Text(
//                           '9 pieces',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Color.fromRGBO(221, 221, 221, 1),
//                               fontFamily: 'Poppins',
//                               fontSize: 16,
//                               letterSpacing: 0,
//                               fontWeight: FontWeight.normal,
//                               height: 1),
//                         )),
//                   ]))),
//           Positioned(
//             top: 32,
//             left: 215,
//             child: //Mask holder Template
//                 const SizedBox(width: 80, height: 80),
//           ),
//         ],
//       ),
//     );