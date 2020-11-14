import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/values/routes.dart' as Routes;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with DisposableWidget {
  LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => this.onWidgetBuild());
  }

  void onWidgetBuild() {
    _loginViewModel.getAuthState();
    _loginViewModel.authState.stream.listen((event) {
      switch (event) {
        case AuthState.unauthent:
          Navigator.pushReplacementNamed(context, Routes.login);
          break;
        case AuthState.authent:
          Navigator.pushReplacementNamed(context, Routes.home);
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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash_screen.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
