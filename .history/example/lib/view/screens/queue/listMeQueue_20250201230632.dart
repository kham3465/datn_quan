import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/detailQueue.dart';
import 'package:flutter_background_geolocation_example/view/screens/queue/me_shedule_queue.dart';

class ListQueueMe extends StatefulWidget {

  const ListQueueMe({super.key});

  @override
  State<ListQueueMe> createState() => _ListQueueMeState();
}

class _ListQueueMeState extends State<ListQueueMe>
    with SingleTickerProviderStateMixin {
      
  late TabController _tabController;
  List<Queue> queueList = [];
  List<Queue> queueListLast = [];
  bool isDataLoading = true; // Trạng thái kiểm tra tải dữ liệu
  Timer? dataTimer; // Timer để kiểm tra sau 30 giây

  @override
  void initState() {
    super.initState();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? idUser = prefs.getInt('idUser');

    _tabController = TabController(length: 2, vsync: this);
    fetchQueueData();

    // Khởi tạo Timer kiểm tra dữ liệu sau 30 giây
    dataTimer = Timer(const Duration(seconds: 30), () {
      if (queueList.isEmpty && queueListLast.isEmpty && mounted) {
        setState(() {
          isDataLoading = false; // Cập nhật trạng thái khi không có dữ liệu
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không có dữ liệu Queue.'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    dataTimer?.cancel(); // Hủy Timer khi thoát màn hình
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchQueueData(int idVehicle) async {
    try {
      final res = await ApiRequest.getListQueue(idVehicle);
      if (res.code == "200" && mounted) {
        List<dynamic> data = res.data;
        setState(() {
          queueList = List<Queue>.from(data
              .where((item) => item['status'].toString() == 'PENDING')
              .map((jsonItem) => Queue.fromJson(jsonItem)));
          queueListLast = List<Queue>.from(data
              .where((item) => item['status'].toString() == 'DONE' ||
                  item['status'].toString() == 'FALSE')
              .map((jsonItem) => Queue.fromJson(jsonItem)));
          isDataLoading = false; 
        print(queueListLast.length);
        });
      } else {
        throw Exception('Lỗi khi lấy dữ liệu Queue');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isDataLoading = false; // Không thành công trong việc tải dữ liệu
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch đăng ký cá nhân'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Danh sách hiện tại'),
            Tab(text: 'Danh sách đã từng đăng ký'),
          ],
        ),
      ),
      body: isDataLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                buildQueueList(queueList, "Không có hàng đợi hiện tại."),
                buildQueueList(queueListLast, "Không có hàng đợi đã hoàn thành."),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MeQueue()),
          );
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }

  Widget buildQueueList(List<Queue> queues, String emptyMessage) {
    if (queues.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: queues.length,
      itemBuilder: (context, index) {
        final queue = queues[index];
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
                  queue.status ?? "",
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
                  builder: (context) => DetailQueue(queueId: queue.id ?? 1),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
