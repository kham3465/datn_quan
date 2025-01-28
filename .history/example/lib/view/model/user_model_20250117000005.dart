import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? licenseScore;
  String? role;
  DateTime? createdTime;
  bool? isActive;
  String? accessToken;

  UserModel({
    this.id,
    this.name,
    this.licenseScore,
    this.role,
    this.createdTime,
    this.isActive,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      licenseScore: json['licenseScore'],
      role: json['role'],
      createdTime: json['createdTime'] != null
          ? DateTime.parse(json['createdTime'])
          : null,
      isActive: json['isActive'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'licenseScore': licenseScore,
      'role': role,
      'createdTime': createdTime?.toIso8601String(),
      'isActive': isActive,
      'accessToken': accessToken,
    };
  }
}
