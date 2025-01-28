import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late String district;
   List data=[];
  final List<String> districts = [
    "BADINH",
    "HOANKIEM",
    "TAYHO",
    "LONGBIEN",
    "CAUGIAY",
    "DONGDA",
    "HAIBATRUNG",
    "HOANGMAI",
    "THANHXUAN",
    "NAMTULIEM",
    "BACTULIEM",
    "HADONG",
    "SONTAY",
    "BAVI",
    "CHUONGMY",
    "DANPHUONG",
    "HOAIDUC",
    "MYDUC",
    "PHUXUYEN",
    "PHUCTHO",
    "QUOCOAI",
    "THACHTHAT",
    "THANHOAI",
    "THANHTRI",
    "UNGHOA"
];

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    final res = await ApiRequest.getListElectric(district);
    setState(() {
      data = res.data;
    });
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
            height: MediaQuery.of(context).size.height /
                2, // Chiều cao là 1 nửa màn hình
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
                      String districtName = districts[index];
                      String formattedDistrict = districtName
                          .toUpperCase()
                          .replaceAll(' ', '') // Loại bỏ dấu cách
                          .replaceAll(
                              RegExp(r'[^\x00-\x7F]'), ''); // Loại bỏ dấu
                      return ListTile(
                        title: Text(formattedDistrict),
                        onTap: () async {
                          setState(() {
                            district = formattedDistrict; 
                          });
                          final res = await ApiRequest.getListElectric(district);
                          if (res.code == "200") {
                            setState(() {
                              data = res.data;
                            });
                          }
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
