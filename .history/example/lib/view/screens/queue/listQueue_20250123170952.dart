import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/detailQueue.dart';

class ListQueue extends StatefulWidget {
  final String district;
  const ListQueue({super.key, required this.district});
  @override
  State<ListQueue> createState() => _ListQueueState();
}
class _ListQueueState extends State<ListQueue> {
    List<Queue> queueList = []; // List to hold the Queue models
  // Function to fetch the queue list
  Future<void> getDataListQueue(String district) async {
    try {
      final res = await ApiRequest.getListQueue( district);
      if (res.code == "200" && context.mounted) {
        setState(() {
          // Update the queue list with fetched data
          queueList = List<Queue>.from(
            res.data.map((jsonItem) => Queue.fromJson(jsonItem)),
          );
        });
      } else {
        throw Exception('Lỗi khi lấy dữ liệu Queue');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getDataListQueue( 'HOANKIEM');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch đăng ký'), // Tiêu đề AppBar
        actions: [
          // Nút "Của tôi" ở góc phải
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Bạn có thể thêm hành động cho nút này ở đây
              // Ví dụ: chuyển đến trang của người dùng hoặc làm gì đó
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nút "Của tôi" đã được nhấn')),
              );
            },
          ),
        ],
      ),
      body: queueList.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Khi đang tải dữ liệu
          : ListView.builder(
              itemCount: queueList.length,
              itemBuilder: (context, index) {
                final queue = queueList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số xe: ${queue.user.numberCar}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          queue.status??" ",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Thời gian bắt đầu: ${queue.timeStart}',
                            style: const TextStyle(fontSize: 14)),
                        Text('Thời gian hết hạn: ${queue.timeOut}',
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailQueue(queueId: queue.id??1),
                        ),
                      ); 
                    },
                  ),
                );
              },
            ),
    );
  }
}
