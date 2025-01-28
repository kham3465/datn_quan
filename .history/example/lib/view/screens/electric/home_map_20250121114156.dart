import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';

class HomeMap extends StatefulWidget {
  final String name;
  final String district;
  const HomeMap({super.key, required this.name, required this.district});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeView(name:'',district:widget.district));
  }
}
