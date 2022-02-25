import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kAppBarHorizontalPadding = EdgeInsets.symmetric(
  horizontal: 24.0,
);

class SwapItAppBar extends AppBar {
  SwapItAppBar({
    Key? key,
    final IconData leadingIconData = SwapItIcons.back,
    final void Function()? leadingPressCallback,
    final String? title,
    final List<Widget> bottomTitle = const [],
  }) : super(
          key: key,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  leadingIconData,
                ),
                onPressed: leadingPressCallback ?? Navigator.of(context).pop,
              );
            },
          ),
          bottom: bottomTitle.isNotEmpty
              ? PreferredSize(
                  child: Padding(
                    padding: _kAppBarHorizontalPadding,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: bottomTitle,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                )
              : null,
          title: title != null
              ? Text(
                  title,
                )
              : null,
        );
}
