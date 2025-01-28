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
    final queueProvider = Provider.of<QueueProvider>(context, listen: false);
    final res = await ApiRequest.getListQueue(status, district);
    if (res.code == "200" && context.mounted) {
 queueProvider.setQueue(Queue.fromJson(res.data['user']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
