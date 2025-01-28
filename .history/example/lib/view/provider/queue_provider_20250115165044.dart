import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/QueueModel.dart';

class QueueProvider with ChangeNotifier {
  // Sử dụng List<Queue> thay vì Queue đơn lẻ
  List<Queue>? _queueList;

  // Getter cho danh sách Queue
  List<Queue>? get queueList => _queueList;

  // Setter để cập nhật danh sách Queue
  void setQueue(List<Queue> queueList) {
    _queueList = queueList;
    notifyListeners(); // Thông báo UI cập nhật khi danh sách thay đổi
  }

  // Phương thức để xóa dữ liệu trong queueList
  void clearQueue() {
    _queueList = null;
    notifyListeners(); // Thông báo UI cập nhật khi danh sách bị xóa
  }
}
