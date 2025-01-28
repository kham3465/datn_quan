import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/screens/electric/listQueue.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/login_screen.dart';

class AppRoutes {
  static const String loginScreen = '/';

  static const String home = '/home';
  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => const LoginScreen(),
    home: (BuildContext context) => const ListQueue(),
  };
}
