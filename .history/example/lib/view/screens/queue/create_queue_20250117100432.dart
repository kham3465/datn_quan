import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/network/api_request.dart';

class CreateQueue extends StatefulWidget {
  const CreateQueue({super.key});

  @override
  State<CreateQueue> createState() => _CreateQueueState();
}

class _CreateQueueState extends State<CreateQueue> {
  Future<void> createQueue(int idUser, int idVehicle) async {
    final res = await ApiRequest.createQueue(idUser, idVehicle);
    if (res.code == "200" && context.mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
