import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';
import 'package:mappin/src/values/colors.dart' as colors;

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  PlatformScaffold({this.appBarTitle, this.body});

  final Widget appBarTitle;
  final Widget body;

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColorDark,
      appBar: appBarTitle == null ? null : AppBar(
        title: appBarTitle,
      ),
      body: body,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: colors.backgroundColorDark,
      navigationBar: appBarTitle == null ? null : CupertinoNavigationBar(
        middle: appBarTitle,
      ),
      child: body,
    );
  }
}
