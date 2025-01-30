
import 'package:bloc_1/Presentation_layer/screens/homescreen.dart';
import 'package:bloc_1/Presentation_layer/screens/second.dart';
import 'package:bloc_1/Presentation_layer/screens/thirdscreen.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(title: ''));

      case '/second':
        return MaterialPageRoute(
            builder: (_) => SecondPage());

      case '/third':
        return MaterialPageRoute(
            builder: (_) => Thirdscreen(title: 'Third Screen'));

      default:
        return null;
    }
  }
}
