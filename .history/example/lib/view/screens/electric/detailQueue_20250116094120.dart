import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class DetailQueue extends StatefulWidget {
  final int queueId; // ID của Queue được truyền từ màn hình trước

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
    getQueue(widget.queueId);  // Lấy dữ liệu Queue khi màn hình được khởi tạo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết Queue'),
      ),
      body: queue == null
          ? Center(child: CircularProgressIndicator())  // Hiển thị loading khi chưa có dữ liệu
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hiển thị trạng thái, thời gian bắt đầu, và thời gian hết hạn
                  Text(
                    'Trạng thái: ${queue!.status}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thời gian bắt đầu: ${queue!.timeStart}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Thời gian hết hạn: ${queue!.timeOut}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // Hiển thị thông tin người dùng
                  Text(
                    'Thông tin người dùng:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tên: ${queue!.user.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Số xe: ${queue!.user.numberCar}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  // Hiển thị thông tin trạm sạc điện
                  Text(
                    'Thông tin trạm sạc:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tên trạm: ${queue!.electricVehicle.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Quận: ${queue!.electricVehicle.district}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
