import 'dart:ui';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/login/LoginTextFieldWidget.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with DisposableWidget {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  void onWidgetBuild() {
    _loginViewModel.loginState.stream.listen((LoginState event) {
      switch (event) {
        case LoginState.success:
          break;
        case LoginState.error:
          EdgeAlert.show(
            context,
            title: 'Erreur',
            description: 'Invalid credentials',
            gravity: EdgeAlert.TOP,
            backgroundColor: colors.alerterErrorColor,
          );
          break;
        case LoginState.noInternet:
          EdgeAlert.show(
            context,
            title: 'Erreur',
            description: 'No internet connection',
            gravity: EdgeAlert.TOP,
            backgroundColor: colors.alerterErrorColor,
          );
          break;
        default:
      }
    }).canceledBy(this);
    _loginViewModel.authState.stream.listen((AuthState event) {
      if (event == AuthState.authent) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(HomeScreen.routeName);
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
            margin: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Hero(
                    tag: 'MappinTitle',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        'Mappin',
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
                  tag: 'ScreenTitle',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        'Welcome!',
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
                const Text(
                  'Sign in to continue',
                  style: TextStyle(
                    fontFamily: fonts.primaryFF,
                    color: colors.smoothLabelColor,
                    fontWeight: fonts.medium,
                    fontSize: 24,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Hero(
                      tag: 'tfUsername',
                      child: Material(
                        type: MaterialType.transparency,
                        child: LoginTextFieldWidget(
                          controllerUsername: _controllerUsername,
                          placeholder: 'Username',
                          svgPath: 'assets/images/tf_username.svg',
                          isPassword: false,
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'tfPassword',
                      child: Material(
                        type: MaterialType.transparency,
                        child: LoginTextFieldWidget(
                          controllerUsername: _controllerPassword,
                          placeholder: 'Password',
                          svgPath: 'assets/images/tf_password.svg',
                          isPassword: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  child: Hero(
                    tag: 'bAction',
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: PlatformButton(
                            color: colors.primaryColor,
                            height: 60,
                            borderRadius: 12,
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontFamily: fonts.primaryFF,
                                color: colors.labelColor,
                                fontWeight: fonts.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPress: () {
                              _loginViewModel.login(_controllerUsername.text,
                                  _controllerPassword.text);
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 20,
                          child: StreamBuilder<bool>(
                            stream: _loginViewModel.isLoading.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              return PlatformProgress(
                                isAnimating: snapshot.data,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  child: PlatformButton(
                    color: colors.primaryTransparentColor,
                    height: 60,
                    borderRadius: 12,
                    child: const Text(
                      'Create an account',
                      style: TextStyle(
                        fontFamily: fonts.primaryFF,
                        color: colors.labelColor,
                        fontWeight: fonts.bold,
                        fontSize: 16,
                      ),
                    ),
                    onPress: () {
                      Navigator.pushNamed(context, '/signup');
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
