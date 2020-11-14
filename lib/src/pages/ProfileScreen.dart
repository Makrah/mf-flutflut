import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<String>(
                stream: _loginViewModel.tokenUser.stream,
                builder: (context, snapshot) {
                  return Text("Token user ---> ${snapshot.data}");
                }),
            PlatformButton(
              child: Text("Logout"),
              onPress: () {
                _loginViewModel.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
