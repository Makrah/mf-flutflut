import 'dart:async';
import 'dart:ui';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/login/LoginTextFieldWidget.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';
import 'package:mappin/src/widgets/platforms/PlatformTextField.dart';
import 'package:mappin/src/values/routes.dart' as Routes;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with DisposableWidget {
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();
  LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => this.onWidgetBuild());
  }

  void onWidgetBuild() {
    _loginViewModel.loginState.stream.listen((event) {
      switch (event) {
        case LoginState.success:
          break;
        case LoginState.error:
          EdgeAlert.show(
            context,
            title: 'Erreur',
            description: 'Identifiants invalids',
            gravity: EdgeAlert.TOP,
            backgroundColor: colors.alerterErrorColor,
          );
          break;
        default:
      }
    }).canceledBy(this);
    _loginViewModel.authState.stream.listen((event) {
      if (event == AuthState.authent) {
        Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(Routes.home);
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
    return PlatformScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: "MappinTitle",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        "Mappin",
                        style: TextStyle(
                          fontFamily: fonts.primaryFF,
                          color: colors.labelColor,
                          fontWeight: fonts.black,
                          fontSize: 42,
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: "ScreenTitle",
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Text(
                        "Welcome!",
                        style: TextStyle(
                          fontFamily: fonts.primaryFF,
                          color: colors.labelColor,
                          fontWeight: fonts.black,
                          fontSize: 42,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Sign in to continue",
                  style: TextStyle(
                    fontFamily: fonts.primaryFF,
                    color: colors.smoothLabelColor,
                    fontWeight: fonts.medium,
                    fontSize: 24,
                  ),
                ),
                Column(
                  children: [
                    Hero(
                      tag: "tfUsername",
                      child: Material(
                        type: MaterialType.transparency,
                        child: LoginTextFieldWidget(
                          controllerUsername: _controllerUsername,
                          placeholder: "Username",
                          svgPath: "assets/images/tf_username.svg",
                        ),
                      ),
                    ),
                    Hero(
                      tag: "tfPassword",
                      child: Material(
                        type: MaterialType.transparency,
                        child: LoginTextFieldWidget(
                          controllerUsername: _controllerPassword,
                          placeholder: "Password",
                          svgPath: "assets/images/tf_password.svg",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  child: Hero(
                    tag: "bAction",
                    child: PlatformButton(
                      color: colors.primaryColor,
                      height: 60,
                      borderRadius: 12,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          fontFamily: fonts.primaryFF,
                          color: colors.labelColor,
                          fontWeight: fonts.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPress: () {
                        _loginViewModel.login(
                            _controllerUsername.text, _controllerPassword.text);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: PlatformButton(
                    color: colors.primaryTransparentColor,
                    height: 60,
                    borderRadius: 12,
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                        fontFamily: fonts.primaryFF,
                        color: colors.labelColor,
                        fontWeight: fonts.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPress: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
