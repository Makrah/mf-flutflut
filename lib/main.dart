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
import 'package:mappin/src/viewModels/ProfileViewModel.dart';

import 'src/values/themeAndroid.dart';

GetIt getIt = GetIt.asNewInstance();

void main() {
  getIt.registerSingleton(LoginViewModel());
  getIt.registerSingleton(ProfileViewModel());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, StatefulWidget Function(BuildContext)> routes =
        <String, StatefulWidget Function(BuildContext)>{
      SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
      LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
      SignupScreen.routeName: (BuildContext context) => const SignupScreen(),
      HomeScreen.routeName: (BuildContext context) => HomeScreen(),
      ProfileScreen.routeName: (BuildContext context) => const ProfileScreen(),
      CreatePostScreen.routeName: (BuildContext context) =>
          const CreatePostScreen(),
      MapScreen.routeName: (BuildContext context) => const MapScreen(),
      PostDetailScreen.routeName: (BuildContext context) =>
          const PostDetailScreen(),
    };
    const String initialRoute = SplashScreen.routeName;
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
