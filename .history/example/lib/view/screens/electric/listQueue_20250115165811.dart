import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/provider/queue_provider.dart';
import 'package:provider/provider.dart';

class ListQueue extends StatefulWidget {
  const ListQueue({super.key});

  @override
  State<ListQueue> createState() => _ListQueueState();
}

class _ListQueueState extends State<ListQueue> {
  // Hàm lấy dữ liệu danh sách Queue từ API
  Future<void> getDataListQueue(String status, String district) async {
    try {
      final queueProvider = Provider.of<QueueProvider>(context, listen: false);
      final res = await ApiRequest.getListQueue(status, district);

      if (res.code == "200" && context.mounted) {
        // Cập nhật danh sách Queue vào QueueProvider
        queueProvider.setQueue(List<Queue>.from(
          res.data.map((jsonItem) => Queue.fromJson(jsonItem))
        ));
      } else {
        throw Exception('Lỗi khi lấy dữ liệu Queue');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e"))
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu mặc định khi màn hình được tạo
    getDataListQueue('PENDING', 'HOANKIEM');
  }

  @override
  Widget build(BuildContext context) {
    // Lắng nghe QueueProvider để lấy danh sách Queue
    final queueProvider = Provider.of<QueueProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Queue'),
      ),
      body: queueProvider.queueList == null
          ? Center(child: CircularProgressIndicator()) // Khi đang tải dữ liệu
          : ListView.builder(
              itemCount: queueProvider.queueList!.length,
              itemBuilder: (context, index) {
                final queue = queueProvider.queueList![index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Hiển thị số xe (numberCar)
                        Text(
                          'Số xe: ${queue.user.numberCar}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Hiển thị trạng thái (PENDING)
                        Text(
                          queue.status,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
    
                        Text('Thời gian bắt đầu: ${queue.timeStart}', style: TextStyle(fontSize: 14)),
                        // Hiển thị thời gian hết hạn (timeOut)
                        Text('Thời gian hết hạn: ${queue.timeOut}', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
