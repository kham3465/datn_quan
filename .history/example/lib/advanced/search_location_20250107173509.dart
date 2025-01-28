import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/map_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateSearchView extends StatefulWidget {
  const DateSearchView({Key? key}) : super(key: key);

  @override
  _DateSearchViewState createState() => _DateSearchViewState();
}

class _DateSearchViewState extends State<DateSearchView> {
  DateTime? startDateTime;
  DateTime? endDateTime;
  int? idUser;

  @override
  void initState() {
    super.initState();
    getIdUser();
  }

  Future<void> getIdUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt('idUser');
  }

  Future<DateTime?> selectDateTime(BuildContext context) async {
    // Chọn ngày
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now(),
    );
    if (date == null) return null; // Nếu không chọn ngày

    // Chọn giờ
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return null; // Nếu không chọn giờ

    // Kết hợp ngày và giờ
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm theo ngày giờ'),
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
                  onPressed: () async {
                    DateTime? selectedDateTime = await selectDateTime(context);
                    if (selectedDateTime != null) {
                      setState(() {
                        startDateTime = selectedDateTime;
                      });
                    }
                  },
                  child: Text(
                    startDateTime != null
                        ? 'Bắt đầu: ${startDateTime!.toString()}'
                        : 'Chọn thời gian bắt đầu',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? selectedDateTime = await selectDateTime(context);
                    if (selectedDateTime != null) {
                      setState(() {
                        endDateTime = selectedDateTime;
                      });
                    }
                  },
                  child: Text(
                    endDateTime != null
                        ? 'Kết thúc: ${endDateTime!.toString()}'
                        : 'Chọn thời gian kết thúc',
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startDateTime != null && endDateTime != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapHistory(
                          createTime: startDateTime ?? DateTime.now(),
                          endTime: endDateTime ?? DateTime.now(),
                          idShip: idUser ?? 1,
                        ),
                      ),
                    );
                  } else {
                    print('Vui lòng chọn đầy đủ thời gian bắt đầu và kết thúc.');
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
