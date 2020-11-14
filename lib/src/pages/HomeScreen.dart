import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mappin/src/pages/CreatePostScreen.dart';
import 'package:mappin/src/pages/MapScreen.dart';
import 'package:mappin/src/pages/PostDetailScreen.dart';
import 'package:mappin/src/pages/ProfileScreen.dart';
import 'package:mappin/src/widgets/bottomNavigation/AdaptativeBottomNavigationScaffold.dart';
import 'package:mappin/src/widgets/bottomNavigation/AppFlow.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Widget build(BuildContext context) =>
      AdaptiveBottomNavigationScaffold(appFlows: appFlows);
}
