import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/widgets/bottomNavigation/AppFlow.dart';

class MaterialBottomNavigationScaffold extends StatelessWidget {
  const MaterialBottomNavigationScaffold({
    @required this.appFlows,
    @required this.onItemSelected,
    @required this.selectedIndex,
    Key key,
  })  : assert(appFlows != null),
        assert(onItemSelected != null),
        assert(selectedIndex != null),
        super(key: key);

  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<AppFlow> appFlows;

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
          children: appFlows
              .map(
                (AppFlow barItem) => _buildIndexedPageFlow(barItem),
              )
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: colors.smoothLabelColor,
          unselectedLabelStyle: const TextStyle(color: colors.smoothLabelColor),
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(color: Colors.white),
          backgroundColor: colors.backgroundColorDark,
          currentIndex: selectedIndex,
          items: appFlows
              .map(
                (AppFlow flow) => BottomNavigationBarItem(
                  label: flow.title,
                  icon: SvgPicture.asset(
                    flow.svgPath,
                    color: selectedIndex == appFlows.indexOf(flow)
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
          return MaterialPageRoute<dynamic>(
              builder: appFlow.routes[appFlow.initialRouteKey],
              settings: settings);
        }
        return MaterialPageRoute<dynamic>(
            builder: appFlow.routes[settings.name], settings: settings);
      },
    );
  }
}
