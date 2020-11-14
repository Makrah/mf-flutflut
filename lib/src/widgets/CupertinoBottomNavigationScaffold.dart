import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/values/colors.dart' as colors;

class CupertinoBottomNavigationScaffold extends StatelessWidget {
  const CupertinoBottomNavigationScaffold({
    @required this.navigationBarItems,
    @required this.onItemSelected,
    @required this.selectedIndex,
    Key key,
  })  : assert(navigationBarItems != null),
        assert(onItemSelected != null),
        assert(selectedIndex != null),
        super(key: key);

  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<AppFlow> navigationBarItems;

  /// Called when a tab selection occurs.
  final ValueChanged<int> onItemSelected;

  final int selectedIndex;

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        // As we're managing the selected index outside, there's no need
        // to make this Widget stateful. We just need pass the selectedIndex to
        // the controller every time the widget is rebuilt.
        controller: CupertinoTabController(initialIndex: selectedIndex),
        tabBar: CupertinoTabBar(
          backgroundColor: colors.backgroundColorDark,
          inactiveColor: colors.smoothLabelColor,
          activeColor: CupertinoColors.white,
          items: navigationBarItems
              .map(
                (flow) => BottomNavigationBarItem(
                  label: flow.title,
                  icon: SvgPicture.asset(
                    flow.svgPath,
                    color: selectedIndex == navigationBarItems.indexOf(flow)
                        ? CupertinoColors.white
                        : colors.smoothLabelColor,
                  ),
                ),
              )
              .toList(),
          onTap: onItemSelected,
        ),
        tabBuilder: (context, index) {
          final barItem = navigationBarItems[index];
          return CupertinoTabView(
            navigatorKey: barItem.navigatorKey,
            onGenerateRoute: (RouteSettings settings) {
              if (barItem.routes[settings.name] == null) {
                return CupertinoPageRoute(
                    builder: barItem.routes[barItem.initialRouteKey],
                    settings: settings);
              }
              return CupertinoPageRoute(
                  builder: barItem.routes[settings.name], settings: settings);
            },
          );
        },
      );

  // Widget _buildIndexedPageFlow(AppFlow appFlow) {
  //   return Navigator(
  //     key: appFlow.navigatorKey,
  //     onGenerateRoute: (RouteSettings settings) {
  //       if (appFlow.routes[settings.name] == null) {
  //         return CupertinoPageRoute(
  //             builder: appFlow.routes[appFlow.initialRouteKey],
  //             settings: settings);
  //       }
  //       return CupertinoPageRoute(
  //           builder: appFlow.routes[settings.name], settings: settings);
  //     },
  //   );
  // }
}
