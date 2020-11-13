import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  void onWidgetBuild() {
    Navigator.pushNamed(context, "/second");
  }

  @override
  void dispose() {
    super.dispose();
    print("bbbbbb");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Mappin",
                  style: TextStyle(
                      fontFamily: "Heebo",
                      fontWeight: FontWeight.w900,
                      fontSize: 42),
                ),
              ),
              Text(
                "Welcome!",
                style: TextStyle(
                    fontFamily: "Heebo",
                    fontWeight: FontWeight.w900,
                    fontSize: 42),
              ),
              Text(
                "Sign in to continue",
                style: TextStyle(
                    fontFamily: "Heebo",
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/images/tf_username.svg",
                      semanticsLabel: 'Acme Logo'),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Username",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        print("a");
                      },
                      child: Text("Sign in"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        print("a");
                      },
                      child: Text("Create an account"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
