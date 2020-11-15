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
import 'package:mappin/src/values/routes.dart' as app_routes;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DisposableWidget {
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();
  final List<AppFlow> appFlows = <AppFlow>[
    AppFlow(
      title: 'Profile',
      svgPath: 'assets/images/icon_tab_profile.svg',
      initialRouteKey: app_routes.profile,
      routes: <String, StatefulWidget Function(dynamic)>{
        app_routes.profile: (dynamic context) => const ProfileScreen(),
        app_routes.postDetail: (dynamic context) => const PostDetailScreen(),
      },
      mainColor: Colors.red,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Camera',
      svgPath: 'assets/images/icon_tab_camera.svg',
      initialRouteKey: app_routes.createPost,
      routes: <String, StatefulWidget Function(dynamic)>{
        app_routes.createPost: (dynamic context) => const CreatePostScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Map',
      svgPath: 'assets/images/icon_tab_map.svg',
      initialRouteKey: app_routes.map,
      routes: <String, StatefulWidget Function(dynamic)>{
        app_routes.map: (dynamic context) => const MapScreen(),
        app_routes.postDetail: (dynamic context) => const PostDetailScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  void onWidgetBuild() {
    _loginViewModel.authState.stream.listen((AuthState event) {
      if (event == AuthState.unauthent) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(app_routes.login);
      }
    }).canceledBy(this);
  }

  @override
  void dispose() {
    super.dispose();
    cancelSubscriptions();
  }

  @override
  Widget build(BuildContext context) =>
      AdaptiveBottomNavigationScaffold(appFlows: appFlows);
}
