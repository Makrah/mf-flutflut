import 'package:flutter/cupertino.dart';

class AppFlow {
  String title;
  String svgPath;
  String initialRouteKey;
  Map<String, StatefulWidget Function(dynamic)> routes;
  Color mainColor;
  GlobalKey<NavigatorState> navigatorKey;

  AppFlow(
      {this.title,
      this.svgPath,
      this.initialRouteKey,
      this.routes,
      this.mainColor,
      this.navigatorKey});
}