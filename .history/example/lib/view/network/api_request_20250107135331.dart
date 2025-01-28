import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'api_base/api_client.dart';
import 'api_base/api_response.dart';

class ApiRequest {
  static const String domain = "http://37.120.222.8:3465/api/v1";

  static Future<ApiResponse> userLogin(String name, String password) async {
    Map data = {"name": name, "password": password};
    return await ApiClient().request(
        url: "$domain/auth/authenticate",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> getLocation(
      int idShip, DateTime createTime, DateTime endTime) async {
    return await ApiClient().request(
        url:
            "$domain/public/location?idShip=${idShip}&startTime=${createTime.toIso8601String()}&endTime=${endTime.toIso8601String()}",
        // data: json.encode(data),
        method: ApiClient.get);
  }

  static Future<ApiResponse> delete(int id) async {
    return await ApiClient().request(
        url: "$domain/admin/ship/delete/${id}",
        // data: json.encode(data),
        method: ApiClient.delete);
  }

  static Future<ApiResponse> getUserInfo() async {
    return await ApiClient()
        .request(url: "$domain/api/v1/user/account", method: ApiClient.get);
  }

  //upload-image
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

  //images
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
