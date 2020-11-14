import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/widgets/BottomNavigationTab.dart';
import 'package:mappin/src/values/colors.dart' as colors;

class MaterialBottomNavigationScaffold extends StatelessWidget {
  const MaterialBottomNavigationScaffold({
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
  Widget build(BuildContext context) => Scaffold(
        // The IndexedStack is what allows us to retain state across tab
        // switches by keeping our views in the widget tree while only showing
        // the selected one.
        body: IndexedStack(
          index: selectedIndex,
          children: navigationBarItems
              .map(
                (barItem) => _buildIndexedPageFlow(barItem),
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: colors.smoothLabelColor,
          unselectedLabelStyle: TextStyle(color: colors.smoothLabelColor),
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Colors.white),
          backgroundColor: colors.backgroundColorDark,
          currentIndex: selectedIndex,
          items: navigationBarItems
              .map(
                (flow) => BottomNavigationBarItem(
                  label: flow.title,
                  icon: SvgPicture.asset(
                    flow.svgPath,
                    color: selectedIndex == navigationBarItems.indexOf(flow)
                        ? Colors.white
                        : colors.smoothLabelColor,
                  ),
                ),
              )
              .toList(),
          onTap: onItemSelected,
        ),
      );

  Widget _buildIndexedPageFlow(AppFlow appFlow) {
    return Navigator(
      key: appFlow.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        if (appFlow.routes[settings.name] == null) {
          return MaterialPageRoute(
              builder: appFlow.routes[appFlow.initialRouteKey],
              settings: settings);
        }
        return MaterialPageRoute(
            builder: appFlow.routes[settings.name], settings: settings);
      },
    );
  }
}
