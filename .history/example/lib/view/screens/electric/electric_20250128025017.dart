import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/listQueue.dart';

class RegisterView extends StatefulWidget {
  final int idUser;
  final int idVehicle;

  const RegisterView(
      {super.key, required this.idUser, required this.idVehicle});
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String selectedSlot = "";

  Future<void> createQueue(int idUser, int idVehicle, String number) async {
    final res = await ApiRequest.createQueue(idUser, idVehicle, number);
    if (res.code == "200") {
      showSuccessDialog(
          context,
          "Thành công",
          " Đăng ký thành công lịch",
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 30,
          ), Colors.green);
    } else {
      showSuccessDialog(
          context,
          "Thất bại",
          "Trạm sạc đang bận, không thể đăng ký được",
          Icon(
            Icons.error_outline,
            color: Color.fromARGB(255, 194, 48, 4),
            size: 30,
          ), const Color.fromARGB(255, 218, 4, 4));
    }
  }

  void showSuccessDialog(
      BuildContext context, String head, String content, Icon icon, Color color) {
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
              Text(
                head,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
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
            icon
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
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

 void _showRegisterDialog(String slot, String number) {
  selectedSlot = slot;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bo góc dialog
        ),
        elevation: 8,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Điều chỉnh kích thước dialog
            children: [
              // Tiêu đề
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Đăng ký $slot",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                   IconButton(
                     icon: Icon(Icons.close, color: Colors.grey.shade600),
                     onPressed: () {
                       Navigator.of(context).pop();
                     },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Nội dung
              Text(
                "Bạn có muốn đăng ký vị trí $slot không?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                   height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              // Các nút bấm
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Hủy",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      createQueue(widget.idUser, widget.idVehicle, number);
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
                        )),
                    child: const Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              onLongPress: () => _showRegisterDialog("Ô Số 1", "ONE"),
              onTap: ()=>ListQueue(idVehicle: idVehicle,),
              icon: Icons.ev_station,
            ),
            SizedBox(height: 20),
            _buildChargingSlot(
              slotNumber: "Ô Số 2",
              onLongPress: () => _showRegisterDialog("Ô Số 2", "TWO"),
              onTap: ()=>ListQueue(),
              icon: Icons.ev_station,
            ),
            SizedBox(height: 20),
            _buildChargingSlot(
              slotNumber: "Ô Số 3",
              onLongPress: () => _showRegisterDialog("Ô Số 3", "THREE"),
              onTap: ()=>ListQueue(),
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
    required VoidCallback onLongPress,
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
