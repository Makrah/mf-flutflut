import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/widgets/login/LoginTextFieldWidget.dart';
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void onWidgetBuild() {
    Navigator.pushNamed(context, '/second');
  }

  @override
  void dispose() {
    super.dispose();
    print('bbbbbb');
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
                        ),
                      ),
                    ),
                    LoginTextFieldWidget(
                      controllerUsername: _controllerConfirmPassword,
                      placeholder: 'Confirm Password',
                      svgPath: 'assets/images/tf_password.svg',
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
                              print('-----------> ${_controllerUsername.text}');
                            },
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
