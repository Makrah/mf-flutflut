import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mappin/src/pages/CreatePostScreen.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/pages/LoginScreen.dart';
import 'package:mappin/src/pages/MapScreen.dart';
import 'package:mappin/src/pages/PostDetailScreen.dart';
import 'package:mappin/src/pages/ProfileScreen.dart';
import 'package:mappin/src/pages/SignupScreen.dart';
import 'package:mappin/src/values/themeiOS.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/pages/SplashScreen.dart';
import 'package:mappin/src/values/themeAndroid.dart';
import 'package:mappin/src/values/routes.dart' as app_routes;

import 'src/values/themeAndroid.dart';

GetIt getIt = GetIt.asNewInstance();

void main() {
  getIt.registerSingleton(LoginViewModel());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, StatefulWidget Function(BuildContext)> routes = <String, StatefulWidget Function(BuildContext)>{
      app_routes.splash: (BuildContext context) => const SplashScreen(),
      app_routes.login: (BuildContext context) => const LoginScreen(),
      app_routes.signup: (BuildContext context) => const SignupScreen(),
      app_routes.home: (BuildContext context) => HomeScreen(),
      app_routes.profile: (BuildContext context) => const ProfileScreen(),
      app_routes.createPost: (BuildContext context) => const CreatePostScreen(),
      app_routes.map: (BuildContext context) => const MapScreen(),
      app_routes.postDetail: (BuildContext context) => const PostDetailScreen(),
    };
    const String initialRoute = app_routes.splash;
    const String title = 'Flutter Demo';
    if (Platform.isIOS) {
      return CupertinoApp(
        routes: routes,
        initialRoute: initialRoute,
        title: title,
        theme: themeiOS,
      );
    }
    return MaterialApp(
      title: title,
      initialRoute: initialRoute,
      routes: routes,
      theme: theme,
      darkTheme: themeDark,
    );
  }
}