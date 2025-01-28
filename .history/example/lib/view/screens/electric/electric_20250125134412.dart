import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  String selectedSlot = "";
  
   Future<void> createQueue(int idUser, int idVehicle) async {
    final res = await ApiRequest.createQueue(idUser, idVehicle);
    if (res.code == "200") {
      showSuccessDialog(context, "Thành công", " Đăng ký thành công lịch");
    } else {
      showSuccessDialog(
          context, "Thất bại", "Trạm sạc đang bận, không thể đăng ký được");
    }
  }
  void showSuccessDialog(BuildContext context, String head, String content) {
  showDialog(
    context: context,
    barrierDismissible: false, // Ngăn chặn đóng hộp thoại khi nhấn ra ngoài
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
        ),
        title: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                head,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.celebration,
              color: Colors.greenAccent,
              size: 40,
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
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

  // Đóng hộp thoại sau 2 giây
 
}



  void _showRegisterDialog(String slot) {
    selectedSlot = slot;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Đăng Ký $slot"),
          content: Text("Bạn muốn đăng ký $slot?"),
          actions: <Widget>[
            TextButton(
              child: Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Đăng Ký"),
              onPressed: () {
                _showSuccessDialog(slot);
              },
            ),
          ],
        );
      },
    );
  }

  // Hiển thị thông báo thành công sau khi đăng ký
  void _showSuccessDialog(String slot) {
    Navigator.of(context).pop(); // Đóng dialog đăng ký
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông Báo"),
          content: Text("Đăng ký $slot thành công!"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng Ký Trạm Sạc"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ô số 1
            GestureDetector(
              onTap: () {
                _showRegisterDialog("Ô Số 1");
              },
              child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Màu nền sáng cho ô
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Ô Số 1",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Ô số 2
            GestureDetector(
              onTap: () {
                _showRegisterDialog("Ô Số 2");
              },
              child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400], // Màu nền sáng cho ô
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Ô Số 2",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Ô số 3
            GestureDetector(
              onTap: () {
                _showRegisterDialog("Ô Số 3");
              },
              child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[500], // Màu nền sáng cho ô
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Ô Số 3",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
