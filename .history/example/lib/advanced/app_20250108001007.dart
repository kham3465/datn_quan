import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/map_view.dart';

import 'dart:async';

import 'home_view.dart';
import 'main_menu_button.dart';

class AdvancedApp extends StatefulWidget {
  static const String NAME = 'advanced';

  @override
  _AdvancedAppState createState() => new _AdvancedAppState();
}

class _AdvancedAppState extends State<AdvancedApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return new MaterialApp(
           debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(secondary:Colors.black),
            brightness: Brightness.light,
            hintColor: Colors.black12,
            primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
              bodyColor: Colors.black,
            )),
        home:
            Scaffold(body: HomeView()));
  }
}
