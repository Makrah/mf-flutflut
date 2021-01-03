import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/pages/LoginScreen.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  static const String routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with DisposableWidget {
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  void onWidgetBuild() {
    _loginViewModel.getAuthState();
    _loginViewModel.authState.stream.listen((AuthState event) {
      switch (event) {
        case AuthState.unauthent:
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          break;
        case AuthState.authent:
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          break;
        default:
      }
    }).canceledBy(this);
  }

  @override
  void dispose() {
    super.dispose();
    cancelSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash_screen.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
