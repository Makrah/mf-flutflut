import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final Widget appBar;
  final Widget body;

  PlatformScaffold({this.appBar, this.body});

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: body,
    );
  }
}
