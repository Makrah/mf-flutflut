import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/FirstScreen.dart';
import 'package:mappin/SecondScreen.dart';
import 'package:mappin/src/pages/CreatePostScreen.dart';
import 'package:mappin/src/pages/LoginScreen.dart';
import 'package:mappin/src/pages/MapScreen.dart';
import 'package:mappin/src/pages/PostDetailScreen.dart';
import 'package:mappin/src/pages/ProfileScreen.dart';
import 'package:mappin/src/pages/SignupScreen.dart';
import 'package:mappin/src/pages/SplashScreen.dart';
import 'package:mappin/src/widgets/AdaptativeBottomNavigationScaffold.dart';
import 'package:mappin/src/widgets/BottomNavigationTab.dart';
import 'package:mappin/src/widgets/TabNavigator.dart';
import 'package:mappin/src/values/colors.dart' as colors;

class AppFlow {
  String title;
  String svgPath;
  String initialRouteKey;
  Map<String, StatefulWidget Function(dynamic)> routes;
  Color mainColor;
  GlobalKey<NavigatorState> navigatorKey;

  AppFlow(
      {this.title,
      this.svgPath,
      this.initialRouteKey,
      this.routes,
      this.mainColor,
      this.navigatorKey});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBarIndex = 0;

  // AppFlow is just a class I created for holding information
  // about our app's flows.
  final List<AppFlow> appFlows = [
    AppFlow(
      title: 'Profile',
      svgPath: "assets/images/icon_tab_profile.svg",
      initialRouteKey: "/profile",
      routes: {
        "/profile": (context) => ProfileScreen(),
        "/postDetail": (context) => PostDetailScreen(),
      },
      mainColor: Colors.red,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Camera',
      svgPath: "assets/images/icon_tab_camera.svg",
      initialRouteKey: "/createPost",
      routes: {
        "/createPost": (context) => CreatePostScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Map',
      svgPath: "assets/images/icon_tab_map.svg",
      initialRouteKey: "/map",
      routes: {
        "/map": (context) => MapScreen(),
        "/postDetail": (context) => PostDetailScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];

  Widget build(BuildContext context) => AdaptiveBottomNavigationScaffold(
        navigationBarItems: appFlows
            // .map(
            //   (flow) => BottomNavigationTab(
            //       bottomNavigationBarItem: BottomNavigationBarItem(
            //         title: Text(flow.title),
            //         icon: Icon(flow.iconData),
            //       ),
            //       navigatorKey: flow.navigatorKey,
            //       initialPageBuilder: (context) => IndexedPage(
            //             index: 1,
            //             backgroundColor: flow.mainColor,
            //             containingFlowTitle: flow.title,
            //           )),
            // )
            // .toList(),
      );

  // @override
  // Widget build(BuildContext context) {
  //   final currentFlow = appFlows[_currentBarIndex];
  //   // We're preventing the root navigator from popping and closing the app
  //   // when the back button is pressed and the inner navigator can handle it.
  //   // That occurs when the inner has more than one page on its stack.
  //   // You can comment the onWillPop callback and watch "the bug".
  //   return WillPopScope(
  //     onWillPop: () async =>
  //         !await currentFlow.navigatorKey.currentState.maybePop(),
  //     child: Scaffold(
  //       body: IndexedStack(
  //         index: _currentBarIndex,
  //         children: appFlows
  //             .map(
  //               _buildIndexedPageFlow,
  //             )
  //             .toList(),
  //       ),
  //       bottomNavigationBar: BottomNavigationBar(
  //         unselectedItemColor: colors.smoothLabelColor,
  //         unselectedLabelStyle: TextStyle(color: colors.smoothLabelColor),
  //         selectedItemColor: Colors.white,
  //         selectedLabelStyle: TextStyle(color: Colors.white),
  //         backgroundColor: colors.backgroundColorDark,
  //         currentIndex: _currentBarIndex,
  //         items: appFlows
  //             .map(
  //               (flow) => BottomNavigationBarItem(
  //                 label: flow.title,
  //                 icon: SvgPicture.asset(
  //                   flow.svgPath,
  //                   color: _currentBarIndex == appFlows.indexOf(flow)
  //                       ? Colors.white
  //                       : colors.smoothLabelColor,
  //                 ),
  //               ),
  //             )
  //             .toList(),
  //         onTap: (newIndex) => setState(
  //           () {
  //             if (_currentBarIndex != newIndex) {
  //               _currentBarIndex = newIndex;
  //             } else {
  //               // If the user is re-selecting the tab, the common
  //               // behavior is to empty the stack.
  //               currentFlow.navigatorKey.currentState
  //                   .popUntil((route) => route.isFirst);
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildIndexedPageFlow(AppFlow appFlow) {
  //   return Navigator(
  //     key: appFlow.navigatorKey,
  //     onGenerateRoute: (RouteSettings settings) {
  //       if (appFlow.routes[settings.name] == null) {
  //         return MaterialPageRoute(
  //             builder: appFlow.routes[appFlow.initialRouteKey],
  //             settings: settings);
  //       }
  //       return MaterialPageRoute(
  //           builder: appFlow.routes[settings.name], settings: settings);
  //     },
  //   );
  // }
}
