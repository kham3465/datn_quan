import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class CreateQueue extends StatelessWidget {
  const CreateQueue({super.key});

  Future<void> createQueue(int idUser, int idVehicle) async {
    final res = await ApiRequest.createQueue(idUser, idVehicle);
    if (res.code == "200") {
      // Xử lý nếu yêu cầu tạo queue thành công.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Queue"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Hiển thị Dialog khi nhấn vào nút
            showDialog(
              context: context,
              barrierDismissible: true, // Cho phép đóng khi nhấn vào ngoài dialog
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3, // Chiều cao bằng 1/3 màn hình
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Tiêu đề của Dialog
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Đăng ký lịch sạc điện",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context); // Đóng dialog khi nhấn vào dấu X
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Khoảng cách giữa tiêu đề và nút
                        // Các nút trong dialog
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn nút Đăng ký
                                createQueue(1, 1); // Thay idUser và idVehicle theo yêu cầu
                                Navigator.pop(context); // Đóng dialog sau khi thực hiện hành động
                              },
                              child: const Text("Đăng ký"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn nút Xem
                                Navigator.pop(context); // Đóng dialog sau khi thực hiện hành động
                                // Có thể mở một trang hoặc hành động khác ở đây
                              },
                              child: const Text("Xem"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text("Hiển thị Dialog"),
        ),
      ),
    );
  }
}
