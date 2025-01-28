import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/provider/queue_provider.dart';
import 'package:flutter_background_geolocation_example/view/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ListQueue extends StatefulWidget {
  const ListQueue({super.key});
  @override
  State<ListQueue> createState() => _ListQueueState();
}

class _ListQueueState extends State<ListQueue> {
  Future<void> getDataListQueue(String status, String district) async {
  try {
    // Lấy đối tượng queueProvider từ context
    final queueProvider = Provider.of<QueueProvider>(context, listen: false);

    // Gọi API để lấy dữ liệu danh sách Queue
    final res = await ApiRequest.getListQueue(status, district);

    // Kiểm tra mã phản hồi và context còn tồn tại
    if (res.code == "200" && context.mounted) {
      // Nếu có dữ liệu, cập nhật dữ liệu cho queueProvider
      queueProvider.setQueue(List<Queue>.from(
        res.data.map((jsonItem) => Queue.fromJson(jsonItem))
      ));
    } else {
      // Xử lý khi không có dữ liệu hoặc có lỗi
      // Bạn có thể thông báo lỗi hoặc làm gì đó tùy vào yêu cầu
      throw Exception('Lỗi khi lấy dữ liệu Queue');
    }
  } catch (e) {
    // Xử lý lỗi nếu có
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e"))
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
