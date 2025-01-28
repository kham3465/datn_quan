import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/model/UserModel.dart';

class DetailQueue extends StatefulWidget {
  final int queueId;

  const DetailQueue({super.key, required this.queueId});

  @override
  State<DetailQueue> createState() => _DetailQueueState();
}

class _DetailQueueState extends State<DetailQueue> {
  Queue? queue;

  Future<void> getQueue(int id) async {
    try {
      final res = await ApiRequest.getQueueById(id);
      if (res.code == "200" && context.mounted) {
        setState(() {
          queue = Queue.fromJson(res.data);
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

  @override
  void initState() {
    super.initState();
    getQueue(widget.queueId);  
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
                  buildUserCard(queue!.user),
                  buildElectricVehicleCard(queue!.electricVehicle),
                ],
              ),
            ),
    );
  }

  Widget buildInfoCard({required IconData icon, required String title, required String? content, Color? color}) {
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
            buildDetailRow('Tên', user.name??"admin"),
            buildDetailRow('Số xe', user.numberCar??""),
            buildDetailRow('Vai trò', user.role),
            buildDetailRow('Thời gian tạo', user.createdTime),
            buildDetailRow('Trạng thái hoạt động', user.isActive ? "Hoạt động" : "Không hoạt động"),
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
            buildDetailRow('Trạng thái bận', ev.isBusy == true ? "Có" : "Không"),
            buildDetailRow('Thời gian tạo', ev.createTime),
            buildDetailRow('Thời gian cập nhật', ev.updateTime ?? "Chưa cập nhật"),
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
