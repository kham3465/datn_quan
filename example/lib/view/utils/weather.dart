import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = '5ec7ddec62c5454b9c941330240507'; // Thay thế YOUR_API_KEY bằng API Key của bạn
String selectedCity = 'Hanoi';
  List<Map<String, dynamic>> weeklyWeather = [];

  final List<String> cities = [ 'Hanoi', 'Ho Chi Minh City', 'Da Nang', 'Nha Trang', 'Vung Tau', 'Ha Long', 'Phu Quoc',
    'Hai Phong', 'Can Tho', 'Hue', 'Quy Nhon', 'Thanh Hoa', 'Thai Nguyen', 'Vinh',
    'Bac Ninh', 'Bien Hoa', 'Buon Ma Thuot', 'Cam Ranh', 'Cao Lanh', 'Dien Bien Phu',
    'Ha Tinh', 'Haiphong', 'Hanoi', 'Hue', 'Lao Cai', 'Long Xuyen', 'Nam Dinh',
    'Phan Rang-Thap Cham', 'Phan Thiet', 'Pleiku', 'Rach Gia', 'Soc Trang', 'Son La',
    'Tam Ky', 'Tan An', 'Thai Binh', 'Thai Nguyen', 'Thanh Hoa', 'Thu Dau Mot', 'Tra Vinh',
    'Tuy Hoa', 'Uong Bi', 'Vinh', 'Vinh Long', 'Vung Tau', 'Yen Bai'];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url = 'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$selectedCity&days=7';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
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
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCity,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue),
                      onChanged: (String? newCity) {
                        setState(() {
                          selectedCity = newCity!;
                          fetchWeatherData();
                        });
                      },
                      items: cities.map<DropdownMenuItem<String>>((String city) {
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
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                'Weather Details for $selectedCity',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherTile extends StatelessWidget {
  final String day;
  final String iconUrl;
  final String temp;

  WeatherTile({required this.day, required this.iconUrl, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin:const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient:const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style:const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Image.network(
            'http:$iconUrl',
            width: 50,
            height: 50,
          ),
          Text(
            temp,
            style:const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}