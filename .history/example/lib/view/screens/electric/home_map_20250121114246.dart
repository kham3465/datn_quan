import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';

class HomeMap extends StatefulWidget {

  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late String district;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeView(name:'',district:district));
  }
}
