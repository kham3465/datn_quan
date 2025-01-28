import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';
import 'package:flutter_background_geolocation_example/view/model/ElectricModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  List data = [];
  LatLng position=LatLng(0,0);
  List<ElectricVehicle> listElectric = [];
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
    List<ElectricVehicle> vehicles = (res.data as List).map((location) {
      return ElectricVehicle.fromJson(location);
    }).toList();
    setState(() {
      listElectric = vehicles;
      data = res.data;
    });
  }

  Future<void> updateData(String selectedDistrict) async {
    try {
      final res = await ApiRequest.getListElectric(selectedDistrict);
      if (res.code == "200") {
        List<ElectricVehicle> vehicles = (res.data as List).map((location) {
          return ElectricVehicle.fromJson(location);
        }).toList();
        if (vehicles.isEmpty) {
          _showNoStationsDialog();
        } else {
          setState(() {
            listElectric = vehicles;
            data = res.data;
          });
        }
      } else {
        _showNoStationsDialog();
      }
    } catch (e) {
      _showErrorDialog(e.toString());
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

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Lỗi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            errorMessage,
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
                  color: Colors.red,
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
      body: HomeView(data: data, position: ,),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDistrictDialog(),
        child: Icon(Icons.location_on),
      ),
      endDrawer: Drawer(
        child: listElectric.isEmpty
            ? Center(child: Text('Không có trạm sạc nào'))
            : ListView.builder(
                itemCount: listElectric.length,
                itemBuilder: (context, index) {
                  final vehicle = listElectric[index];
                  return ListTile(
                    leading: Icon(
                      vehicle.isBusy == true ? Icons.bus_alert : Icons.check_circle,
                      color: vehicle.isBusy == true ? Colors.red : Colors.green,
                    ),
                    title: Text(
                      vehicle.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      vehicle.isBusy == true
                          ? 'Trạng thái: Đang bận'
                          : 'Trạng thái: Có thể đăng ký',
                      style: TextStyle(
                        color: vehicle.isBusy == true ? Colors.red : Colors.green,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        position=LatLng(vehicle.latitude, );
                      });
                      
                    },
                  );
                },
              ),
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
                          Navigator.of(context).pop();
                          await updateData(apiName);
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
