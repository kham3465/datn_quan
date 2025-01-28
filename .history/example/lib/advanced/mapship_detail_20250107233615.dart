import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_geolocation_example/view/model/ship_model.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class ShipListMap extends StatefulWidget {
  const ShipListMap({Key? key}) : super(key: key);

  @override
  _ShipListMapState createState() => _ShipListMapState();
}

class _ShipListMapState extends State<ShipListMap> {
  List<Ship> list = [];
  Set<int> selectedIds = Set(); // Set để lưu trữ các ID của tàu đã được đánh dấu

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    try {
      final res = await ApiRequest.getListShip();
      if (res.code == "200") {
        setState(() {
          list.clear();
          for (var shipData in res.data) {
            Ship ship = Ship.fromJson(shipData);
            list.add(ship);
          }
          print('List of ships: $list');
        });
      } else {
        print('Failed to fetch ships: ${res.message}');
      }
    } catch (e) {
      print('Error fetching ships: $e');
    }
  }

 


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(200, 200, 200, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchShip()));},child: Icon(Icons.search)),
                Text(
                  "Danh sách tàu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Icon(Icons.insert_drive_file),
              ],
            ),
          ),
          Image.asset(
            AppImages.shipl,
            width: width,
            fit: BoxFit.cover,
          ),

        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tàu trong hệ thống",
              style: TextStyle(
                fontSize: 18, // Điều chỉnh kích cỡ font chữ tại đây
                fontWeight: FontWeight.bold, // Để in đậm văn bản
                color: const Color.fromARGB(255, 115, 193, 231), // Đổi màu văn bản nếu cần
              ),
            ),
          ),
        ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                Ship ship = list[index];
                return GestureDetector(
                  
                  onTap: () {
                    
                  },
                  child: ShipDetail(
                    image: ship.ava,
                    name: ship.name,
                    date: ship.createdTime.toString(),
                    nationality: ship.nationality,
                    portRegistry: ship.portRegistry,
                 
                  ),
                );
              },
            ),
          ),
          
          
        ],
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
    // Default image path in case image is null or empty
    String defaultImagePath = "http://157.10.44.228:3465/api/v1/file/view/1kNYhhfN-ship2.png";

    // Determine the image path to use
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
