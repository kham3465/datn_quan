
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/app.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';
import 'package:flutter_background_geolocation_example/advanced/search_location.dart';
import 'package:flutter_background_geolocation_example/view/screens/home/home_page.dart';
import 'package:flutter_background_geolocation_example/view/screens/login/login_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/change_pass_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/work_board_screen.dart';

class AppRoutes {
  static const String loginScreen = '/';
  
        static const String home = '/home';
  static final routes = <String, WidgetBuilder>{
    //login
    loginScreen: (BuildContext context) => const LoginScreen(),
   home: (BuildContext context) => const   DateSearchView(),
  };

}