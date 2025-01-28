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
idUser=prefs.getInt('idUser');
  }
  void searchByDateRange() {
    if (startDate != null && endDate != null) {
      print('Start Date: ${startDate!.toIso8601String()}');
      print('End Date: ${endDate!.toIso8601String()}');
    } else {
      print('Please select both start and end dates.');
    }
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
                      lastDate: DateTime.now(),
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
                      lastDate: DateTime.now(),
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
                  if (startDate != null && endDate != null ) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapHistory(
                          createTime: startDate??DateTime.now(),
                          endTime: endDate??DateTime.now(),
                          idShip: idUser??1,
                        ),
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

class ShipDetail extends StatelessWidget {
  final String? image;
  final String? name;
  final String? date;
  final String? nationality;
  final String? portRegistry;
  final bool isSelected; // Biến để xác định xem tàu có được đánh dấu không

  const ShipDetail({
    Key? key,
    this.image,
    this.name,
    this.date,
    this.nationality,
    this.portRegistry,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Đường dẫn mặc định cho hình ảnh
    String defaultImagePath = "http://157.10.44.228:3465/api/v1/file/view/1kNYhhfN-ship2.png";

    // Xác định đường dẫn hình ảnh cần sử dụng
    String imagePath = image ?? defaultImagePath;
    if (image == "") {
      imagePath = defaultImagePath;
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[100] : Colors.blueGrey[50], // Màu nền khác nhau cho tàu được đánh dấu và không
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "Tên tàu",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Ngày tạo: ${date ?? ""}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  "Quốc tịch: ${nationality ?? ""}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  "Cảng đăng ký: ${portRegistry ?? ""}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "Mô tả: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
