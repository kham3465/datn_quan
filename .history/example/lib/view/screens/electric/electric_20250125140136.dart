import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class RegisterView extends StatefulWidget {
  final int idUser;
  final int idVehicle;
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String selectedSlot = "";

  Future<void> createQueue(int idUser, int idVehicle, String number) async {
    final res = await ApiRequest.createQueue(idUser, idVehicle, number);
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
                createQueue(idUser, idVehicle, number);
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
        backgroundColor: Colors.white, // White AppBar
        foregroundColor: Colors.black87, // Black text on AppBar
        elevation: 1, // Add a subtle elevation
        centerTitle: true, // Center the title
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Text(
              "Chọn ô sạc:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),
            _buildChargingSlot(
              slotNumber: "Ô Số 1",
              onTap: () => _showRegisterDialog("Ô Số 1"),
              icon: Icons.ev_station,
            ),
            SizedBox(height: 20),
            _buildChargingSlot(
              slotNumber: "Ô Số 2",
              onTap: () => _showRegisterDialog("Ô Số 2"),
              icon: Icons.ev_station,
            ),
            SizedBox(height: 20),
            _buildChargingSlot(
              slotNumber: "Ô Số 3",
              onTap: () => _showRegisterDialog("Ô Số 3"),
              icon: Icons.ev_station,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChargingSlot({
    required String slotNumber,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                icon ?? Icons.battery_charging_full,
                size: 40,
                color: Colors.blueAccent,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  slotNumber,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}