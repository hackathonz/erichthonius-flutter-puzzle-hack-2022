import 'package:flutter/material.dart';
import 'package:swap_it/l10n/app_localizations.dart';
import 'package:swap_it/widgets/widgets.dart';

class DifficultyView extends StatelessWidget {
  const DifficultyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: ListView(
          children: [
            const SwapItAlternativeLogo(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 44.0),
            ),
            SwapItButton(
              text: localizations.play,
              onPressed: () {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
            ),
            SwapItButton(
              text: localizations.ccontinue,
              onPressed: () {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 44.0),
            ),
            Row(
              children: [
                IconBase(
                  child: const Icon(
                    Icons.help_outline,
                  ),
                  onPressed: () {},
                ),
                IconBase.alternative(
                  child: const Icon(
                    Icons.play_arrow,
                    size: kIconAlternativeSize,
                  ),
                  onPressed: () {},
                ),
                IconBase(
                  child: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {},
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
          primary: false,
        ),
      ),
    );
  }
}
