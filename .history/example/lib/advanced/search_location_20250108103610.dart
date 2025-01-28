import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/map_history.dart';
import 'package:flutter_background_geolocation_example/view/model/ship_model.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateSearchView extends StatefulWidget {
  const DateSearchView({Key? key}) : super(key: key);

  @override
  _DateSearchViewState createState() => _DateSearchViewState();
}

class _DateSearchViewState extends State<DateSearchView> {
  DateTime? startDate;
  DateTime? endDate;
  int? idUser;

  @override
  void initState() {
    super.initState();
    getIdUser();
  }

  Future<void> getIdUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? idUser = prefs.getInt('idUser');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm theo ngày'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020, 1, 1),
                      lastDate: DateTime(2026, 1, 1),
                    ).then((date) {
                      setState(() {
                        startDate = date;
                      });
                    });
                  },
                  child: Text(
                    startDate != null
                        ? 'Start Date: ${startDate!.toIso8601String().split('T')[0]}'
                        : 'Select Start Date',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020, 1, 1),
                      lastDate: DateTime(2026, 1, 1),
                    ).then((date) {
                      setState(() {
                        endDate = date;
                      });
                    });
                  },
                  child: Text(
                    endDate != null
                        ? 'End Date: ${endDate!.toIso8601String().split('T')[0]}'
                        : 'Select End Date',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startDate != null && endDate != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapHistory(
                            idUser: idUser ?? 1,
                            createTime: startDate ?? DateTime.now(),
                            endTime: endDate ?? DateTime.now())
                      ),
                    );
                  } else {
                    print('Please select a date range and a ship.');
                  }
                },
                child: Text('Tìm kiếm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
