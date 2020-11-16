import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mappin/src/widgets/platforms/PlatformWidget.dart';

class PlatformProgress extends PlatformWidget<Widget, Widget> {
  PlatformProgress({this.isAnimating});

  final bool isAnimating;

  @override
  Widget createAndroidWidget(BuildContext context) {
    if (isAnimating) {
      return const Center(
        child: SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget createIosWidget(BuildContext context) {
    if (isAnimating) {
      return const CupertinoActivityIndicator();
    }
    return const SizedBox.shrink();
  }
}
