
import 'package:covid19_app/data/model/country_response.dart';
import 'package:covid19_app/domain/entities/favorite_entity.dart';
import 'package:covid19_app/presentation/detail/detail_route.dart';
import 'package:covid19_app/presentation/detail_favorite/detail_favorite_route.dart';
import 'package:covid19_app/presentation/home/home_route.dart';
import 'package:covid19_app/presentation/login/login_route.dart';
import 'package:covid19_app/presentation/register/register_route.dart';
import 'package:flutter/material.dart';

enum RouteDefine {
  homeScreen,
  loginScreen,
  registerScreen,
  detailFavoriteScreen,
  detailScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
      RouteDefine.loginScreen.name: (_) => LoginRoute.route,
      RouteDefine.registerScreen.name: (_) => RegisterRoute.route,
      RouteDefine.detailScreen.name: (_) => DetailRoute.route(settings.arguments as Country),
      RouteDefine.detailFavoriteScreen.name: (_) => DetailFavoriteRoute.route(settings.arguments as FavoriteCountry),
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
