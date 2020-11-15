import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  PlatformScaffold({this.appBar, this.body});

  final Widget appBar;
  final Widget body;

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return Scaffold(
      appBar: appBar as PreferredSizeWidget,
      body: body,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget,
      child: body,
    );
  }
}
