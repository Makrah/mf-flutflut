import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => this.onWidgetBuild());
  }

  void onWidgetBuild() {
    Navigator.pushNamed(context, "/login");
  }

  @override
  void dispose() {
    super.dispose();
    print("bbbbbb");
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
