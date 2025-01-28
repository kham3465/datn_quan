import 'package:flutter_background_geolocation_example/view/model/ElectricModel.dart';
import 'package:flutter_background_geolocation_example/view/model/UserModel.dart';

class Queue {
  int? id;
  String? status;
  String? timeStart;
  String? timeEnd;
  String? timeOut;
  String? number;
  UserModel user;
  ElectricVehicle electricVehicle;

  Queue({
    required this.id,
    required this.status,
    required this.timeStart,
    this.timeEnd,
    required this.timeOut,
    required this.number,
    required this.user,
    required this.electricVehicle,
  });

  factory Queue.fromJson(Map<String, dynamic> json) {
    return Queue(
      id: json['id'],
      status: json['status'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      timeOut: json['timeOut'],
      
      user: UserModel.fromJson(json['user']),
      electricVehicle: ElectricVehicle.fromJson(json['electricVehicle']),
    );
  }

  // Convert Queue instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'timeOut': timeOut,
      'user': user.toJson(),
      'electricVehicle': electricVehicle.toJson(),
    };
  }
}
