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

  // Hàm chọn ngày và giờ
  Future<void> _selectDateAndTime(BuildContext context, bool isStart) async {
    // Chọn ngày
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2026, 1, 1),
    );

    if (pickedDate != null) {
      // Chọn giờ và phút
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        // Kết hợp ngày và giờ
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStart) {
            startDate = combinedDateTime;
          } else {
            endDate = combinedDateTime;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm theo ngày và giờ'),
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
                  onPressed: () => _selectDateAndTime(context, true),
                  child: Text(
                    startDate != null
                        ? 'Start Date: ${startDate!.toIso8601String().split('T')[0]} ${startDate!.hour}:${startDate!.minute}'
                        : 'Select Start Date and Time',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDateAndTime(context, false),
                  child: Text(
                    endDate != null
                        ? 'End Date: ${endDate!.toIso8601String().split('T')[0]} ${endDate!.hour}:${endDate!.minute}'
                        : 'Select End Date and Time',
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
