import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class DateSearchView extends StatefulWidget {
  const DateSearchView({Key? key}) : super(key: key);

  @override
  _DateSearchViewState createState() => _DateSearchViewState();
}

class _DateSearchViewState extends State<DateSearchView> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? startDateTime;
  DateTime? endDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm theo ngày giờ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chọn thời gian bắt đầu:"),
            DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) async {
                return await showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(2020, 1, 1),
                      lastDate: DateTime.now(),
                    ) ??
                    currentValue;
              },
              onChanged: (value) {
                setState(() {
                  startDateTime = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text("Chọn thời gian kết thúc:"),
            DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) async {
                return await showDatePicker(
                      context: context,
                      initialDate: currentValue ?? DateTime.now(),
                      firstDate: DateTime(2020, 1, 1),
                      lastDate: DateTime.now(),
                    ) ??
                    currentValue;
              },
              onChanged: (value) {
                setState(() {
                  endDateTime = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (startDateTime != null && endDateTime != null) {
                  print('Start: $startDateTime');
                  print('End: $endDateTime');
                } else {
                  print('Vui lòng chọn cả thời gian bắt đầu và kết thúc!');
                }
              },
              child: const Text('Tìm kiếm'),
            ),
          ],
        ),
      ),
    );
  }
}
