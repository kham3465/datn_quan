import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  List data = [];
  final Map<String, String> districts = {
    "Ba Đình": "BADINH",
    "Hoàn Kiếm": "HOANKIEM",
    "Tây Hồ": "TAYHO",
    "Long Biên": "LONGBIEN",
    "Cầu Giấy": "CAUGIAY",
    "Đống Đa": "DONGDA",
    "Hai Bà Trưng": "HAIBATRUNG",
    "Hoàng Mai": "HOANGMAI",
    "Thanh Xuân": "THANHXUAN",
    "Nam Từ Liêm": "NAMTULIEM",
    "Bắc Từ Liêm": "BACTULIEM",
    "Hà Đông": "HADONG",
    "Sơn Tây": "SONTAY",
    "Ba Vì": "BAVI",
    "Chương Mỹ": "CHUONGMY",
    "Đan Phượng": "DANPHUONG",
    "Hoài Đức": "HOAIDUC",
    "Mỹ Đức": "MYDUC",
    "Phú Xuyên": "PHUXUYEN",
    "Phúc Thọ": "PHUCTHO",
    "Quốc Oai": "QUOCOAI",
    "Thạch Thất": "THACHTHAT",
    "Thanh Oai": "THANHOAI",
    "Thanh Trì": "THANHTRI",
    "Ứng Hòa": "UNGHOA"
  };

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final res = await ApiRequest.getListElectric("HOANKIEM");
    setState(() {
      data = res.data;
    });
  }

  Future<void> updateData(String selectedDistrict) async {
    final res = await ApiRequest.getListElectric(selectedDistrict);
    if (res.code == "200") {
      if (res.data == []) {
         _showNoStationsDialog();
      } else {
        setState(() {
          data = res.data;
        });
      }
    } else {
      _showNoStationsDialog();
    }
  }

  void _showNoStationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Thông Báo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Quận này hiện tại không có trạm sạc nào.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn Quận')),
      body: HomeView(data: data),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDistrictDialog(),
        child: Icon(Icons.location_on),
      ),
    );
  }

  void _showDistrictDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chọn Quận",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: districts.length,
                    itemBuilder: (context, index) {
                      String displayName = districts.keys.elementAt(index);
                      String apiName = districts.values.elementAt(index);
                      return ListTile(
                        title: Text(displayName),
                        onTap: () async {
                        
                          await updateData(apiName);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
