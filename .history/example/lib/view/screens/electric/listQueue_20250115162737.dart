import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class ListQueue extends StatefulWidget {
  const ListQueue({super.key});
  @override
  State<ListQueue> createState() => _ListQueueState();
}

class _ListQueueState extends State<ListQueue> {
  Future<void> getDataListQueue(String status, String district) async {
    final res = await ApiRequest.getListQueue(status, district);
    if (res.code == "200" && context.mounted) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
