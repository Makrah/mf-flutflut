import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/pages/CreatePostScreen.dart';
import 'package:mappin/src/pages/MapScreen.dart';
import 'package:mappin/src/pages/PostDetailScreen.dart';
import 'package:mappin/src/pages/ProfileScreen.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/bottomNavigation/AdaptativeBottomNavigationScaffold.dart';
import 'package:mappin/src/widgets/bottomNavigation/AppFlow.dart';
import 'package:mappin/src/values/routes.dart' as Routes;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DisposableWidget {
  LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();
  final List<AppFlow> appFlows = [
    AppFlow(
      title: 'Profile',
      svgPath: "assets/images/icon_tab_profile.svg",
      initialRouteKey: Routes.profile,
      routes: {
        Routes.profile: (context) => ProfileScreen(),
        Routes.postDetail: (context) => PostDetailScreen(),
      },
      mainColor: Colors.red,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Camera',
      svgPath: "assets/images/icon_tab_camera.svg",
      initialRouteKey: Routes.createPost,
      routes: {
        Routes.createPost: (context) => CreatePostScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Map',
      svgPath: "assets/images/icon_tab_map.svg",
      initialRouteKey: Routes.map,
      routes: {
        Routes.map: (context) => MapScreen(),
        Routes.postDetail: (context) => PostDetailScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => this.onWidgetBuild());
  }

  void onWidgetBuild() {
    _loginViewModel.authState.stream.listen((event) {
      if (event == AuthState.unauthent) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(Routes.login);
      }
    }).canceledBy(this);
  }

  @override
  void dispose() {
    super.dispose();
    cancelSubscriptions();
  }

  Widget build(BuildContext context) =>
      AdaptiveBottomNavigationScaffold(appFlows: appFlows);
}
