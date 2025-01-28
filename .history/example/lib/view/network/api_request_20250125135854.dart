import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'api_base/api_client.dart';
import 'api_base/api_response.dart';

class ApiRequest {
  static const String domain = "http://103.75.180.177:3541/api/v1";
  static Future<ApiResponse> userLogin(String name, String password) async {
    Map data = {"name": name, "password": password};
    return await ApiClient().request(
        url: "$domain/auth/authenticate",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> userRegister(
      String name, String numberCar, String password) async {
    Map<String, dynamic> data = {
      "name": name,
      "numberCar": numberCar,
      "password": password
    };
    return await ApiClient().request(
        url: "$domain/auth/register",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> createQueue(int idUser, int idVehicle, ) async {
    Map data = {"idUser": idUser, "idVehicle": idVehicle};
    return await ApiClient().request(
        url: "$domain/public/queue_create",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> getListQueue(
    int idVeghicle,
  ) async {
    return await ApiClient().request(
        url:
            "$domain/public/get_list_queue?idElectric=${idVeghicle}",
        // data: json.encode(data),
        method: ApiClient.get);
  }

   static Future<ApiResponse> getQueueById(
    int id
  ) async {
    return await ApiClient().request(
        url:
            "$domain/public/get_queue/${id}",
        // data: json.encode(data),
        method: ApiClient.get);
  }
  static Future<ApiResponse> getQueueMe(
    int idUser,
  ) async {
    return await ApiClient().request(
        url:
            "$domain/public/get_list_queue?idUser=${idUser}",
        // data: json.encode(data),
        method: ApiClient.get);
  }

// chỗ này là câc api của trụ sạc
static Future<ApiResponse> getElectricById(
    int id
  ) async {
    return await ApiClient().request(
        url:
            "$domain/public/get_electric/${id}",
        // data: json.encode(data),
        method: ApiClient.get);
  }

static Future<ApiResponse> getListElectric(
    String district
  ) async {
    return await ApiClient().request(
        url:"$domain/public/get_list_electric?district=${district}",
        // data: json.encode(data),
        method: ApiClient.get);
  }

  static Future<ApiResponse> uploadImages({
    required XFile imagePaths,
  }) async {
    MultipartFile imageFiles;
    imageFiles = (await MultipartFile.fromFile(
      imagePaths.path,
      filename: imagePaths.path.split('/').last,
      contentType: MediaType('image', 'jpg'),
    ));
    Map<String, dynamic> data = {"files": imageFiles};
    return await ApiClient().request(
        url: "$domain/file/upload", formData: data, method: ApiClient.post);
  }

 static Future<ApiResponse> getLocation(
      int idUser, DateTime createTime, DateTime endTime) async {
    return await ApiClient().request(
        url:
            "$domain/public/find?idUser=${idUser}&startTime=${createTime.toIso8601String()}&endTime=${endTime.toIso8601String()}",
        // data: json.encode(data),
        method: ApiClient.post);
  }
  static Future<ApiResponse> getLocationNew(
      int idUser) async {
    return await ApiClient().request(
        url:
            "$domain/public/latest/${idUser}",
        // data: json.encode(data),
        method: ApiClient.get);
  }
  static Future<ApiResponse> uploadListImages({
    required List<XFile> imagePaths,
  }) async {
    List<MultipartFile> imageFiles = [];
    for (XFile imagePath in imagePaths) {
      imageFiles.add(await MultipartFile.fromFile(
        imagePath.path,
        filename: imagePath.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }
    Map<String, dynamic> data = {
      "files": imageFiles,
    };
    return await ApiClient().request(
        url: "$domain/api/v1/file/upload",
        formData: data,
        method: ApiClient.post);
  }
}
