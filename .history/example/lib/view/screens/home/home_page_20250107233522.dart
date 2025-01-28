import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/ListUserService.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_background_geolocation_example/view/app/app_routes.dart';
import 'package:flutter_background_geolocation_example/view/provider/user_provider.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/screens/user/listUserSailor.dart';
import 'package:flutter_background_geolocation_example/view/utils/weather.dart';
import 'package:flutter_background_geolocation_example/advanced/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = '5ec7ddec62c5454b9c941330240507';
  String selectedCity = 'Hanoi';
  List<Map<String, dynamic>> weeklyWeather = [];

  final List<String> cities = [
    'Hanoi',
    'Da Nang',
    'Nha Trang',
    'Vung Tau',
    'Ha Long',
    'Phu Quoc',
    'Hai Phong',
    'Can Tho',
    'Hue',
    'Quy Nhon',
    'Thanh Hoa',
    'Thai Nguyen',
    'Vinh',
    'Bac Ninh',
    'Bien Hoa',
    'Cam Ranh',
    'Cao Lanh',
    'Dien Bien Phu',
    'Ha Tinh',
    'Haiphong',
    'Lao Cai',
    'Long Xuyen',
    'Nam Dinh',
    'Phan Thiet',
    'Pleiku',
    'Rach Gia',
    'Soc Trang',
    'Son La',
    'Tam Ky',
    'Tan An',
    'Thai Binh',
    'Tra Vinh',
    'Tuy Hoa',
    'Uong Bi',
    'Vinh Long',
    'Yen Bai',
    'Vinh Phuc'
  ];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url =
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$selectedCity&days=7';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> weatherList = data['forecast']['forecastday'];

      setState(() {
        weeklyWeather = weatherList.map((weather) {
          final day = DateTime.parse(weather['date']).weekday;
          final iconUrl = weather['day']['condition']['icon'];
          final temp = weather['day']['avgtemp_c'].toString() + '°C';

          return {
            "day": getDayOfWeek(day),
            "iconUrl": iconUrl,
            "temp": temp,
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final role = userProvider.user?.role;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.beach),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(245, 255, 235, 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chào ${userProvider.user?.name ?? ''}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Chúc bạn một ngày tốt lành",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.notification_add_sharp, color: Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Divider(
              color: Color.fromRGBO(255, 255, 255, 1),
              height: 1,
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Thời tiết trong tuần",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weeklyWeather.length,
                      itemBuilder: (context, index) {
                        final weather = weeklyWeather[index];
                        return WeatherTile(
                          day: weather['day'],
                          iconUrl: weather['iconUrl'],
                          temp: weather['temp'],
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCity,
                        icon: const SizedBox.shrink(),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        onChanged: (String? newCity) {
                          setState(() {
                            selectedCity = newCity!;
                            fetchWeatherData();
                          });
                        },
                        items:
                            cities.map<DropdownMenuItem<String>>((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromRGBO(255, 255, 255, 1),
              height: 1,
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hệ thống quản lý",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: HomeGrid(role: role),
            ),
          ],
        ),
      ),
    );
  }
}
class HomeGrid extends StatelessWidget {
  final String? role;

  HomeGrid({Key? key, this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvancedApp(),
                  ),
                );
              },
              child: ChildMenu(
                image: AppImages.location,
                label: "Vị trí",
              ),
            ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreenService(),
                    ),
                  );
                },
                child: ChildMenu(
                  image: AppImages.accb,
                  label: "Kiểm tra vị trí hiện tại",
                ),
              ),
          ],
        ),
      ],
    );
  }
}
class ChildMenu extends StatelessWidget {
  final String? label;
  final String? image;

  ChildMenu({
    Key? key,
    this.label,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label ?? "No Label",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
