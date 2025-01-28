import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart' as picker;

class DateSearchView extends StatefulWidget {
  const DateSearchView({Key? key}) : super(key: key);

  @override
  _DateSearchViewState createState() => _DateSearchViewState();
}

class _DateSearchViewState extends State<DateSearchView> {
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 1, 1),
                      maxTime: DateTime.now(),
                      onConfirm: (dateTime) {
                        setState(() {
                          startDateTime = dateTime;
                        });
                      },
                      currentTime: startDateTime ?? DateTime.now(),
                      locale: picker.LocaleType.en,
                    );
                  },
                  child: Text(
                    startDateTime != null
                        ? 'Start: ${startDateTime!.toIso8601String()}'
                        : 'Select Start DateTime',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 1, 1),
                      maxTime: DateTime.now(),
                      onConfirm: (dateTime) {
                        setState(() {
                          endDateTime = dateTime;
                        });
                      },
                      currentTime: endDateTime ?? DateTime.now(),
                      locale: picker.LocaleType.en,
                    );
                  },
                  child: Text(
                    endDateTime != null
                        ? 'End: ${endDateTime!.toIso8601String()}'
                        : 'Select End DateTime',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startDateTime != null && endDateTime != null) {
                    print('Start DateTime: ${startDateTime.toString()}');
                    print('End DateTime: ${endDateTime.toString()}');
                    // Thực hiện logic tìm kiếm tại đây.
                  } else {
                    print('Please select start and end date/time.');
                  }
                },
                child: const Text('Tìm kiếm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
