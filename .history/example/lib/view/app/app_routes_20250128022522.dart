import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/screens/electric/home_map.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/register.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/listQueue.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/login_screen.dart';

class AppRoutes {
  static const String loginScreen = '/';
static const String register='/register';
  static const String home = '/home';
  static final routes = <String, WidgetBuilder>{
    loginScreen: (BuildContext context) => const LoginScreen(),
    home: (BuildContext context) => const MainApp(),
     register: (BuildContext context) => const RegisterScreen(),
  };
}
