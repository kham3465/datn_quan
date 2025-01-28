class UserModel1 {
  int id;
  String name;
  String numberCar;
  String role;
  String createdTime;
  bool isActive;
  UserModel1({
    required this.id,
    required this.name,
    required this.numberCar,
    required this.role,
    required this.createdTime,
    required this.isActive,
  });
  // Factory constructor to create a User from JSON
  factory UserModel1.fromJson(Map<String, dynamic> json) {
    return UserModel1(
      id: json['id'],
      name: json['name'],
      numberCar: json['numberCar'],
      role: json['role'],
      createdTime: json['createdTime'],
      isActive: json['isActive'],
    );
  }
  // Convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'numberCar': numberCar,
      'role': role,
      'createdTime': createdTime,
      'isActive': isActive,
    };
  }
}
