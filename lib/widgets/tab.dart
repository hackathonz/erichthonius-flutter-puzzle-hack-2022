import 'package:flutter/material.dart';
import 'package:swap_it/widgets/widgets.dart';

const _kTabSpacing = 27.0;

class SwapItTab extends StatelessWidget {
  final String label;

  final bool active;

  const SwapItTab({
    Key? key,
    required final this.label,
    required final this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Color tabColor;
    late TextStyle labelTextStyle;

    if (active) {
      tabColor = activeTabColor;
      labelTextStyle = activeTabLabelTextStyle;
    } else {
      tabColor = inactiveTabColor;
      labelTextStyle = inactiveTabLabelTextStyle;
    }

    return Container(
      width: kTabSize.width,
      height: kTabSize.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kTabRadius),
        color: tabColor,
      ),
      child: Text(
        label,
        style: labelTextStyle,
        textAlign: TextAlign.center,
      ),
      alignment: Alignment.center,
    );
  }
}

class SwapItTabBar extends StatefulWidget {
  final List<TabOption> tabs;

  const SwapItTabBar({
    Key? key,
    required final this.tabs,
  }) : super(key: key);

  @override
  State<SwapItTabBar> createState() => _SwapItTabBarState();
}

class _SwapItTabBarState extends State<SwapItTabBar> {
  late List<TabOption> tabs;

  late int indexOfActiveTab;

  @override
  void initState() {
    super.initState();

    tabs = widget.tabs;

    indexOfActiveTab = tabs.indexWhere((x) => x.isActive);

    if (indexOfActiveTab < 0) {
      indexOfActiveTab = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          for (var i = 0; i < tabs.length; i++)
            GestureDetector(
              child: SwapItTab(
                label: tabs[i].label,
                active: tabs[i].isActive,
              ),
              onTap: () {
                setState(
                  () {
                    tabs[i] = tabs[i].copyWith(
                      isActive: true,
                    );

                    tabs[indexOfActiveTab] = tabs[indexOfActiveTab].copyWith(
                      isActive: false,
                    );

                    indexOfActiveTab = i;
                  },
                );

                tabs[i].onPressed();
              },
            ),
        ],
        spacing: _kTabSpacing,
      ),
      decoration: BoxDecoration(
        color: tabBarColor,
        borderRadius: BorderRadius.circular(kTabRadius),
      ),
      alignment: Alignment.center,
      height: kTabBarSize.height,
    );
  }
}

class TabOption {
  final String label;

  final bool isActive;

  final void Function() onPressed;

  const TabOption({
    required final this.label,
    required final this.isActive,
    required final this.onPressed,
  });

  TabOption copyWith({
    bool? isActive,
  }) {
    return TabOption(
      isActive: isActive ?? this.isActive,
      label: label,
      onPressed: onPressed,
    );
  }
}
