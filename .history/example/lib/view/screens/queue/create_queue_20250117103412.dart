import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class CreateQueue extends StatefulWidget {
  final String name;
  final String district;
  final bool status;

  const CreateQueue({
    super.key,
    required this.name,
    required this.district,
    required this.status,
  });

  @override
  _CreateQueueState createState() => _CreateQueueState();
}

class _CreateQueueState extends State<CreateQueue> {
  Future<void> createQueue(int idUser, int idVehicle) async {
    final res = await ApiRequest.createQueue(idUser, idVehicle);
    if (res.code == "200") {
      showSuccessDialog(context, "Thành công", " Đăng ký thành công lịch");
    }else{
            showSuccessDialog(context, "Thất bại", "Trạm sạc đang bận, không thể đăng ký được");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Hiển thị Dialog khi nhấn vào nút
            showDialog(
              context: context,
              barrierDismissible:
                  true, // Cho phép đóng khi nhấn vào ngoài dialog
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height /
                        3, // Chiều cao bằng 1/3 màn hình
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
                                Navigator.pop(
                                    context); // Đóng dialog khi nhấn vào dấu X
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 20), // Khoảng cách giữa tiêu đề và nội dung

                        // Thông tin trụ sạc và quận
                        Text(
                          "Trụ sạc: ${widget.name}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Quận: ${widget.district}",
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(
                            height:
                                20), // Khoảng cách giữa thông tin và các nút

                        // Các nút trong dialog
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn nút Đăng ký
                                createQueue(1,
                                    1); // Thay idUser và idVehicle theo yêu cầu
                                Navigator.pop(
                                    context); // Đóng dialog sau khi thực hiện hành động
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.status
                                    ? Colors.green
                                    : Colors.red, // Màu nút dựa trên status
                              ),
                              child: const Text("Đăng ký"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Xử lý sự kiện khi nhấn nút Xem
                                Navigator.pop(
                                    context); // Đóng dialog sau khi thực hiện hành động
                                // Có thể mở một trang hoặc hành động khác ở đây
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.yellow, // Màu nút Xem luôn là vàng
                              ),
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

  void showSuccessDialog(BuildContext context, String head, String content) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Ngăn chặn việc đóng hộp thoại khi nhấn ra bên ngoài
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(head),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn nút "OK"
              },
            ),
          ],
        );
      },
    );

    // Đóng hộp thoại sau 2 giây
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
