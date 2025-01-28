import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';
import 'package:flutter_background_geolocation_example/view/provider/queue_provider.dart';
import 'package:provider/provider.dart';

class DetailQueue extends StatefulWidget {
  const DetailQueue({super.key});

  @override
  State<DetailQueue> createState() => _DetailQueueState();
}

class _DetailQueueState extends State<DetailQueue> {
  late Queue? queue;
  Future<void> getQueue(int id) async {
    try {
      final res = await ApiRequest.getQueueById(id);
      if (res.code == "200" && context.mounted) {
       queue=res.data[]
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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
