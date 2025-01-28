import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String selectedSlot = "";
  final int idUser = 1; // Replace with the actual user ID
  final int idVehicle = 1; // Replace with the actual vehicle ID
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
      barrierDismissible: false,
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
                Navigator.of(context).pop();
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
                // Call API create queue here
                createQueue(idUser, idVehicle);
                Navigator.of(context).pop(); // Close the dialog
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
        backgroundColor: Colors.blue, // Màu nền appbar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chọn ô sạc:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            // Ô số 1
            _buildChargingSlot(
              slotNumber: "Ô Số 1",
              color: Colors.green[300]!,
              onTap: () => _showRegisterDialog("Ô Số 1"),
            ),
            SizedBox(height: 12),
            // Ô số 2
            _buildChargingSlot(
              slotNumber: "Ô Số 2",
              color: Colors.blue[300]!,
              onTap: () => _showRegisterDialog("Ô Số 2"),
            ),
            SizedBox(height: 12),
            // Ô số 3
            _buildChargingSlot(
              slotNumber: "Ô Số 3",
              color: Colors.orange[300]!,
              onTap: () => _showRegisterDialog("Ô Số 3"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargingSlot({
    required String slotNumber,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            slotNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}