import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/detailQueue.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/me_shedule_queue.dart';


class ListQueueMe extends StatefulWidget {
  final int idVehicle;

  const ListQueueMe({super.key, required this.idVehicle});

  @override
  State<ListQueueMe> createState() => _ListQueueMeState();
}

class _ListQueueMeState extends State<ListQueueMe>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Queue> queueList = [];

  Future<void> getDataListQueue(int idVehicle) async {
    try {
      final res = await ApiRequest.getListQueue(idVehicle);
      if (res.code == "200" && context.mounted) {
        setState(() {
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
    _tabController = TabController(length: 2, vsync: this);
    getDataListQueue(widget.idVehicle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch đăng ký cá nhân'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Danh sách hiện tại '),
            Tab(text: 'Danh sách đã từng đăng ký'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildQueueList(),
          buildQueueListlast(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeQueue(), // Màn hình kiểm tra Queue hôm nay
            ),
          );
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }

  Widget buildQueueList() {
    return queueList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: queueList.length,
            itemBuilder: (context, index) {
              final queue = queueList[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        queue.status ?? " ",
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
                        builder: (context) =>
                            DetailQueue(queueId: queue.id ?? 1),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
   Widget buildQueueListlast() {
    return queueList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: queueList.length,
            itemBuilder: (context, index) {
              final queue = queueList[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        queue.status ?? " ",
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
                        builder: (context) =>
                            DetailQueue(queueId: queue.id ?? 1),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}


