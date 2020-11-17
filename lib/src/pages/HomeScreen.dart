import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/pages/CreatePostScreen.dart';
import 'package:mappin/src/pages/LoginScreen.dart';
import 'package:mappin/src/pages/MapScreen.dart';
import 'package:mappin/src/pages/PostDetailScreen.dart';
import 'package:mappin/src/pages/ProfileScreen.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/bottomNavigation/AdaptativeBottomNavigationScaffold.dart';
import 'package:mappin/src/widgets/bottomNavigation/AppFlow.dart';
import 'package:mappin/src/values/constants.dart' as app_routes;

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DisposableWidget {
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();
  final List<AppFlow> appFlows = <AppFlow>[
    AppFlow(
      title: 'Profile',
      svgPath: 'assets/images/icon_tab_profile.svg',
      initialRouteKey: ProfileScreen.routeName,
      routes: <String, StatefulWidget Function(dynamic)>{
        ProfileScreen.routeName: (dynamic context) => const ProfileScreen(),
        PostDetailScreen.routeName: (dynamic context) => const PostDetailScreen(),
      },
      mainColor: Colors.red,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Camera',
      svgPath: 'assets/images/icon_tab_camera.svg',
      initialRouteKey: CreatePostScreen.routeName,
      routes: <String, StatefulWidget Function(dynamic)>{
        CreatePostScreen.routeName: (dynamic context) => const CreatePostScreen(),
      },
      mainColor: Colors.green,
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
    AppFlow(
      title: 'Map',
      svgPath: 'assets/images/icon_tab_map.svg',
      initialRouteKey: MapScreen.routeName,
      routes: <String, StatefulWidget Function(dynamic)>{
        MapScreen.routeName: (dynamic context) => const MapScreen(),
        PostDetailScreen.routeName: (dynamic context) => const PostDetailScreen(),
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
            .pushReplacementNamed(LoginScreen.routeName);
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
