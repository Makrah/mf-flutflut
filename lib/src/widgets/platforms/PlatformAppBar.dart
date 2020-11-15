import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';

class PlatformAppBar extends PlatformWidget<CupertinoNavigationBar, AppBar> {
  PlatformAppBar({this.title});

  final Widget title;

  @override
  AppBar createAndroidWidget(BuildContext context) {
    return AppBar(
      title: title,
    );
  }

  @override
  CupertinoNavigationBar createIosWidget(BuildContext context) {
    return CupertinoNavigationBar(
      middle: title,
    );
  }
}
