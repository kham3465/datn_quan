import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';

class QueueProvider with ChangeNotifier {
  Queue? _queue;

  Queue? get queue => _queue;

  void setQueue(Queue queue) {
    _queue = queue;
    notifyListeners();
  }

  void clearQueue() {
    _queue = null;
    notifyListeners();
  }
}