import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/model/UserModel.dart';
import 'package:flutter_background_geolocation_example/view/model/ElectricModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeQueue extends StatefulWidget {
  const MeQueue({super.key});

  @override
  State<MeQueue> createState() => _MeQueueState();
}

class _MeQueueState extends State<MeQueue> {
  Queue? queue;
    List<Queue> queueList = [];

  Future<void> getQueue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = await prefs.getInt('idUser');
    try {
      final res = await ApiRequest.getQueueMe(id ?? 1);
      if (res.code == "200" && context.mounted) {
        setState(() {
       List<dynamic> data = res.data;
          queueList = List<Queue>.from(
            data.where((item) => (item['status'].toString()=='PENDING')).map((jsonItem) => Queue.fromJson(jsonItem))
          );
queue=queueList[0];
        });
      } else {
        throw Exception('Lỗi khi lấy dữ liệu Queue');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi: $e")));
      }
    }
  }

  Future<void> cancelQueue() async {
    // Đây là nơi bạn sẽ gọi API hủy lịch
    try {
      // Thực hiện gọi API tại đây (logic API sẽ cập nhật sau)
      await Future.delayed(Duration(seconds: 2)); // Placeholder giả lập API
      setState(() {
        queue = null; // Xóa queue sau khi hủy
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Hủy lịch thành công")));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi khi hủy lịch: $e")));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getQueue();
  }

  void showCancelConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Xác nhận hủy lịch"),
        content: Text("Bạn có chắc chắn muốn hủy lịch này không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Không"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await cancelQueue(); // Thực hiện hủy lịch
            },
            child: Text("Hủy lịch"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết Queue'),
      ),
      body: queue == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  buildInfoCard(
                    icon: Icons.info,
                    title: 'Trạng thái',
                    content: queue!.status,
                    color: Colors.orange,
                  ),
                  buildInfoCard(
                    icon: Icons.access_time,
                    title: 'Thời gian bắt đầu',
                    content: queue!.timeStart,
                  ),
                  buildInfoCard(
                    icon: Icons.timer_off,
                    title: 'Thời gian hết hạn',
                    content: queue!.timeOut,
                  ),
                   buildInfoCard(
                    icon: Icons.timer_off,
                    title: 'Thời gian kết thúc dự kiến',
                    content: queue!.timeOut,
                  ),
                  buildUserCard(queue!.user),
                  buildElectricVehicleCard(queue!.electricVehicle),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: showCancelConfirmationDialog,
                    icon: Icon(Icons.cancel, color: Colors.white),
                    label: Text("Hủy lịch"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildInfoCard(
      {required IconData icon,
      required String title,
      required String? content,
      Color? color}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.black, size: 30),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color ?? Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    content ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserCard(UserModel user) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue, size: 30),
                SizedBox(width: 16),
                Text(
                  'Thông tin người dùng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            buildDetailRow('Tên', user.name),
            buildDetailRow('Số xe', user.numberCar),
            buildDetailRow('Vai trò', user.role),
            buildDetailRow('Thời gian tạo', user.createdTime),
            buildDetailRow('Trạng thái hoạt động',
                user.isActive ? "Hoạt động" : "Không hoạt động"),
          ],
        ),
      ),
    );
  }

  Widget buildElectricVehicleCard(ElectricVehicle ev) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_gas_station, color: Colors.green, size: 30),
                SizedBox(width: 16),
                Text(
                  'Thông tin trạm sạc',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            buildDetailRow('Tên trạm', ev.name),
            buildDetailRow('Quận', ev.district),
            buildDetailRow('Vĩ độ', ev.latitude),
            buildDetailRow('Kinh độ', ev.longitude),
            buildDetailRow('Thời gian tạo', ev.createTime),
            buildDetailRow(
                'Thời gian cập nhật', ev.updateTime ?? "Chưa cập nhật"),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
