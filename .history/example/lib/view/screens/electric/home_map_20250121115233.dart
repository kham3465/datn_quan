import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/advanced/home_view.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  late String district; // District sẽ là tên quận được chọn

  // Danh sách các quận Hà Nội
  final List<String> districts = [
    "Ba Đình", "Hoàn Kiếm", "Tây Hồ", "Long Biên", "Cầu Giấy",
    "Đống Đa", "Hai Bà Trưng", "Hoàng Mai", "Thanh Xuân", "Nam Từ Liêm",
    "Bắc Từ Liêm", "Hà Đông", "Sơn Tây", "Ba Vì", "Chương Mỹ",
    "Đan Phượng", "Hoài Đức", "Mỹ Đức", "Phú Xuyên", "Phúc Thọ",
    "Quốc Oai", "Thạch Thất", "Thanh Oai", "Thanh Trì", "Ứng Hòa"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn Quận')),
      body: HomeView(name: '', district: district?? "HOANKIEM"),
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
            height: MediaQuery.of(context).size.height / 2, // Chiều cao là 1 nửa màn hình
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
                      // Chuyển quận thành chữ hoa, viết liền và không dấu
                      String formattedDistrict = districtName
                          .toUpperCase()
                          .replaceAll(' ', '') // Loại bỏ dấu cách
                          .replaceAll(RegExp(r'[^\x00-\x7F]'), ''); // Loại bỏ dấu
                      return ListTile(
                        title: Text(formattedDistrict),
                        onTap: () {
                          setState(() {
                            district = formattedDistrict; // Cập nhật district với tên quận đã được xử lý
                          });
                          Navigator.of(context).pop(); // Đóng dialog khi chọn xong
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
