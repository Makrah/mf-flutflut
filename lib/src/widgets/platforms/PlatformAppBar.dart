import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';

class PlatformAppBar extends PlatformWidget<CupertinoNavigationBar, AppBar> {
  final Widget leading;
  final Widget title;

  PlatformAppBar(this.leading, this.title);

  @override
  AppBar createAndroidWidget(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
    );
  }

  @override
  CupertinoNavigationBar createIosWidget(BuildContext context) {
    return CupertinoNavigationBar(
      leading: leading,
      middle: title,
    );
  }
}
