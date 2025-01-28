import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/listMeQueue.dart';
import 'package:flutter_background_geolocation_example/view/screens/electric/home_map.dart';
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

   static const List<Widget> _widgetOptions = <Widget>[
    HomeMap(),  // Tab 1: Bản đồ
    ListQueueMe(idVehicle: 1)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Home',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Me',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}