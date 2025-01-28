import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? phone;
  String? email;
  DateTime? dob;
  String? address;
  String? company;
  String? role;
  int? hasShip;
  DateTime? createdTime;
  DateTime? updateTime;
  String? level;
  String? token;
  DateTime? timeToken;
  bool? isActive;
  String? status;
  String? nickName;
  String? ava;
  String? accessToken;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.dob,
    this.address,
    this.company,
    this.role,
    this.hasShip,
    this.createdTime,
    this.updateTime,
    this.level,
    this.token,
    this.timeToken,
    this.isActive,
    this.status,
    this.nickName,
    this.ava,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      address: json['address'],
      company: json['company'],
      role: json['role'],
      hasShip: json['has_ship'],
      createdTime: json['createdTime'] != null
          ? DateTime.parse(json['createdTime'])
          : null,
      updateTime:
          json['updateTime'] != null ? DateTime.parse(json['updateTime']) : null,
      level: json['level'],
      token: json['token'],
      timeToken: json['timeToken'] != null ? DateTime.parse(json['timeToken']) : null,
      isActive: json['isActive'],
      status: json['status'],
      nickName: json['nickName'],
      ava: json['ava'],
      accessToken: json['accessToken'],
    );
  }
}