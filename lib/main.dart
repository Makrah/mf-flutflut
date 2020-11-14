import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mappin/src/pages/LoginScreen.dart';
import 'package:mappin/src/values/themeiOS.dart';
import 'package:rxdart/subjects.dart';
import 'package:mappin/FirstScreen.dart';
import 'package:mappin/SecondScreen.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/LoginDto.dart';
import 'package:mappin/src/pages/SplashScreen.dart';
import 'package:mappin/src/services/LocalStorageService.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/themeAndroid.dart';

import 'src/values/themeAndroid.dart';
import 'src/values/themeAndroid.dart';

class Counter {
  final ApiService apiService = ApiService();

  BehaviorSubject count = BehaviorSubject.seeded(0);
  final loginState = PublishSubject<LoginState>();
  final username = BehaviorSubject<String>.seeded("");

  void login() async {
    try {
      final resp = await apiService.login(LoginDto("mistralaix", "Test1234*"));
      print(resp.token);
      username.add(resp.user.username);
      LocalStorageService.set(StorageKeys.token, resp.token);
      loginState.add(LoginState.success);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        // No internet
      } else {
        // print("Error ------> ${error.response.statusCode}");
      }
      loginState.add(LoginState.error);
    }
  }

  void getUserMe() async {
    try {
      final resp = await apiService.getUserMe();
      print(resp.user.username);
    } on DioError catch (error) {
      if (error.type != DioErrorType.DEFAULT) {
        // No internet
      } else {
        // print("Error ------> ${error.response.statusCode}");
      }
      loginState.add(LoginState.error);
    }
  }
}

GetIt getIt = new GetIt.asNewInstance();

void main() {
  getIt.registerSingleton(Counter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = {
      "/": (context) => SplashScreen(),
      "/login": (context) => LoginScreen(),
      "/first": (context) => FirstScreen(),
      "/second": (context) => SecondScreen(),
      // Todo continuer ici
    };
    final initialRoute = "/";
    final title = "Flutter Demo";
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have liked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
