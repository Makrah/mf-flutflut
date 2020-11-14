import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/values/font.dart' as fonts;
import 'package:mappin/src/widgets/platforms/PlatformButton.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';
import 'package:mappin/src/widgets/platforms/PlatformTextField.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerUsername = TextEditingController();

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
    return PlatformScaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
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
              Container(
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/tf_username.svg"),
                        SizedBox(width: 20),
                        Expanded(
                            child: PlatformTextField(
                          placeholder: "Username",
                          controller: _controllerUsername,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: PlatformButton(
                        color: colors.primaryTransparentColor,
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
                          print("-----------> ${_controllerUsername.text}");
                        },
                      ),
                      // child: CupertinoButton(
                      //   color: colors.primaryTransparentColor,
                      //   minSize: 60,
                      //   child: Text(
                      //     "Sign in",
                      //     style: TextStyle(
                      //       fontFamily: fonts.primaryFF,
                      //       color: colors.labelColor,
                      //       fontWeight: fonts.bold,
                      //       fontSize: 16,
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     print("-----------> ${_controllerUsername.text}");
                      //   },
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
