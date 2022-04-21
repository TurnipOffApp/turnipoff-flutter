import 'package:flutter/material.dart';

import 'constants/route_constant.dart';
import 'screens/ActorScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/MovieDetailsScreen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case actor:
        return MaterialPageRoute(builder: (_) => ActorScreen(id: settings.arguments as String));
      case moviePath:
        return MaterialPageRoute(builder: (_) => MovieScreen(id: settings.arguments as String));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
