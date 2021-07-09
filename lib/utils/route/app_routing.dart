
import 'package:covid19_app/presentation/home/home_route.dart';
import 'package:flutter/material.dart';

enum RouteDefine {
  loginScreen,
  homeScreen,
  registerScreen,
}
class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
    };
    final routeBuilder = routes[settings.name];
    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
extension RouteExt on Object {
  String get name => toString().substring(toString().indexOf('.') + 1);
}
