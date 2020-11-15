import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';

class PlatformButton extends PlatformWidget<CupertinoButton, FlatButton> {
  PlatformButton(
      {this.onPress, this.child, this.color, this.height, this.borderRadius, this.horizontalPadding = 16});

  final Function onPress;
  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final double horizontalPadding;

  @override
  FlatButton createAndroidWidget(BuildContext context) {
    return FlatButton(
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: color,
      onPressed: () {
        onPress();
      },
      child: child,
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      color: color,
      minSize: height,
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
      onPressed: () {
        onPress();
      },
    );
  }
}
