import 'dart:ui';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/main.dart';
import 'package:mappin/src/pages/HomeScreen.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/enums.dart';
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/viewModels/LoginViewModel.dart';
import 'package:mappin/src/viewModels/SignupViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/login/LoginTextFieldWidget.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  static const String routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with DisposableWidget {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final SignupViewModel _signupViewModel = SignupViewModel();
  final LoginViewModel _loginViewModel = getIt.get<LoginViewModel>();

  void showError(BuildContext context, String description) {
    EdgeAlert.show(
      context,
      title: 'Error',
      description: description,
      gravity: EdgeAlert.TOP,
      backgroundColor: colors.alerterErrorColor,
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => onWidgetBuild());
  }

  void onWidgetBuild() {
    _signupViewModel.signupState.stream.listen((SignupState event) {
      switch (event) {
        case SignupState.success:
          _loginViewModel.authState.add(AuthState.authent);
          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(HomeScreen.routeName);
          break;
        case SignupState.error:
          showError(context, 'Invalid credentials');
          break;
        case SignupState.noInternet:
          showError(context, 'No internet connection');
          break;
        case SignupState.invalidUsername:
          showError(context, 'Invalid username');
          break;
        case SignupState.invalidPassword:
          showError(context, 'Invalid password');
          break;
        case SignupState.passwordsDontMatch:
          showError(context, 'Your passwords don\'t match');
          break;
        default:
      }
    }).canceledBy(this);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
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
                        'Signup',
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
                    LoginTextFieldWidget(
                      controllerUsername: _controllerConfirmPassword,
                      placeholder: 'Confirm Password',
                      svgPath: 'assets/images/tf_password.svg',
                      isPassword: true,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: PlatformButton(
                          color: colors.primaryTransparentColor,
                          height: 60,
                          borderRadius: 12,
                          child:
                              SvgPicture.asset('assets/images/arrow_back.svg'),
                          onPress: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
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
                                    'Next',
                                    style: TextStyle(
                                      fontFamily: fonts.primaryFF,
                                      color: colors.labelColor,
                                      fontWeight: fonts.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPress: () {
                                    _signupViewModel.signup(
                                        _controllerUsername.text,
                                        _controllerPassword.text,
                                        _controllerConfirmPassword.text);
                                  },
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 20,
                                child: StreamBuilder<bool>(
                                  stream: _signupViewModel.isLoading.stream,
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
                    ],
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
