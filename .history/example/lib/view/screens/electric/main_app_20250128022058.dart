import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/home_map.dart';
import 'package:flutter_background_geolocation_example/view/settings_screen.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/list_queue_me.dart'; // Import màn hình ListQueueMe

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

   static const List<Widget> _widgetOptions = <Widget>[
    HomeMap(),  // Tab 1: Bản đồ
    ListQueueMe(idVehicle: 1,),//Tab 2: Lịch Sử Queue
    SettingsScreen(), //Tab 3: Cài đặt
    
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
            label: '',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}