import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';
import 'package:flutter_background_geolocation_example/view/model/ElectricModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:latlong2/latlong.dart';

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
    final res = await ApiRequest.getListElectric("HAIBATRUNG");
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
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        titlePadding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 0,
        ),
        title: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.redAccent,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Thông Báo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          'Quận này hiện tại không có trạm sạc nào.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
        ),
        contentPadding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 12,
          bottom: 24,
        ),
        title: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.redAccent,
              size: 30,
            ),
            const SizedBox(width: 12),
            Text(
              'Lỗi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          errorMessage,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
      appBar: AppBar(title: Text('Bản đồ trạm sạc')),
      body: HomeView(data: data, position: position,),
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
                        position=LatLng( double.parse(vehicle.latitude), double.parse(vehicle.longitude));
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
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Text(
                "Chọn Quận",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              
              // Danh sách quận
              Expanded(
                child: ListView.separated(
                  itemCount: districts.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    String displayName = districts.keys.elementAt(index);
                    String apiName = districts.values.elementAt(index);
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () async {
                        Navigator.of(context).pop();
                        await updateData(apiName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              displayName,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
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
