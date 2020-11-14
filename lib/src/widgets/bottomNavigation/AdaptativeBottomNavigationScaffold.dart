import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/widgets/bottomNavigation/AppFlow.dart';
import 'package:mappin/src/widgets/bottomNavigation/CupertinoBottomNavigationScaffold.dart';
import 'package:mappin/src/widgets/bottomNavigation/MaterialBottomNavigationScaffold.dart';

class AdaptiveBottomNavigationScaffold extends StatefulWidget {
  const AdaptiveBottomNavigationScaffold({
    @required this.appFlows,
    Key key,
  })  : assert(appFlows != null),
        super(key: key);

  /// List of the tabs to be displayed with their respective navigator's keys.
  final List<AppFlow> appFlows;

  @override
  _AdaptiveBottomNavigationScaffoldState createState() =>
      _AdaptiveBottomNavigationScaffoldState();
}

class _AdaptiveBottomNavigationScaffoldState
    extends State<AdaptiveBottomNavigationScaffold> {
  int _currentlySelectedIndex = 0;

  @override
  Widget build(BuildContext context) => WillPopScope(
        // We're preventing the root navigator from popping and closing the app
        // when the back button is pressed and the inner navigator can handle
        // it. That occurs when the inner has more than one page on its stack.
        // You can comment the onWillPop callback and watch "the bug".
        onWillPop: () async => !await widget
            .appFlows[_currentlySelectedIndex].navigatorKey.currentState
            .maybePop(),
        child: Platform.isAndroid
            ? _buildMaterial(context)
            : _buildCupertino(context),
      );

  Widget _buildCupertino(BuildContext context) =>
      CupertinoBottomNavigationScaffold(
        appFlows: widget.appFlows,
        onItemSelected: onTabSelected,
        selectedIndex: _currentlySelectedIndex,
      );

  Widget _buildMaterial(BuildContext context) =>
      MaterialBottomNavigationScaffold(
        appFlows: widget.appFlows,
        onItemSelected: onTabSelected,
        selectedIndex: _currentlySelectedIndex,
      );

  /// Called when a tab selection occurs.
  void onTabSelected(int newIndex) {
    if (_currentlySelectedIndex == newIndex) {
      // If the user is re-selecting the tab, the common
      // behavior is to empty the stack.
      widget.appFlows[newIndex].navigatorKey.currentState
          .popUntil((route) => route.isFirst);
    }
    setState(() {
      _currentlySelectedIndex = newIndex;
    });
  }
}
