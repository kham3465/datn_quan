import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/detailQueue.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/listMeQueue.dart';

class ListQueue extends StatefulWidget {
  final int idVehicle;

  const ListQueue({super.key, required this.idVehicle});

  @override
  State<ListQueue> createState() => _ListQueueState();
}

class _ListQueueState extends State<ListQueue>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Queue> queueList1 = [];
  List<Queue> queueList2 = [];
  List<Queue> queueList3 = [];
  bool _isLoading = true;
  int _selectedTabIndex = 0; // Thêm biến để theo dõi tab hiện tại


  Future<void> getDataListQueue(int idVehicle) async {
    try {
      final res = await ApiRequest.getListQueue(idVehicle);
      if (res.code == "200" && context.mounted) {
          // Chia danh sách thành 3 phần dựa trên id
          List<dynamic> data = res.data;
          queueList1 = List<Queue>.from(
            data.where((item) => (item['number'].equals('ONE'))).map((jsonItem) => Queue.fromJson(jsonItem))
          );
            queueList2 = List<Queue>.from(
            data.where((item) => (item['id'].equals('TWO'))).map((jsonItem) => Queue.fromJson(jsonItem))
          );
            queueList3 = List<Queue>.from(
            data.where((item) => (item['id'].)).map((jsonItem) => Queue.fromJson(jsonItem))
          );
          setState(() {
           _isLoading = false;
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
          setState(() {
           _isLoading = false;
          });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
          _selectedTabIndex = _tabController.index; // Cập nhật tab hiện tại
        });
    });
    getDataListQueue(widget.idVehicle);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch đăng ký'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListQueueMe(idVehicle: widget.idVehicle),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body:  _isLoading
          ? const Center(
              child: CircularProgressIndicator())
          : TabBarView(
            controller: _tabController,
            children: [
              _buildQueueList(queueList1),
               _buildQueueList(queueList2),
               _buildQueueList(queueList3),
            ],
      )
    );
  }

  Widget _buildQueueList(List<Queue> queueList) {
     return queueList.isEmpty
          ? const Center(
              child: Text('Không có dữ liệu'),) 
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