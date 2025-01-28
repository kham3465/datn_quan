class ElectricVehicle {
  int id;
  String name;
  String longitude;
  String latitude;
  String district;

  String createTime;


  ElectricVehicle({
    required this.id,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.district,
    required this.createTime,

  });

  // Factory constructor to create an ElectricVehicle from JSON
  factory ElectricVehicle.fromJson(Map<String, dynamic> json) {
    return ElectricVehicle(
      id: json['id'],
      name: json['name'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      district: json['district'],
   
      createTime: json['createTime'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'district': district,
      'createTime': createTime,
      'updateTime': updateTime,
    };
  }
}
