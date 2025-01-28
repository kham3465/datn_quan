import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';

class UserProvider with ChangeNotifier {
  Queue? _queue;

  Queue? get user => _queue;

  void setUser(Queue queue) {
    _queue = queue;
    notifyListeners();
  }

  void clearUser() {
    _queue = null;
    notifyListeners();
  }
}