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

  static Future<ApiResponse> getListShip() async {
    return await ApiClient().request(
        url: "$domain/admin/ship/list",
        // data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> getListShipfor(
      String name, String nationaly, String typeShip) async {
    return await ApiClient().request(
        url:
            "$domain/admin/ship/list?name=${name}&typeShip=${typeShip}&nationaly=${nationaly}",
        // data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> createLocation(
      String longitude, String latitude, int idShip) async {
    Map data = {"longitude": longitude, "latitude": latitude, "idShip": idShip};
    return await ApiClient().request(
        url: "$domain/public/create/location",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> getLocation(
      int idShip, DateTime createTime, DateTime endTime) async {
    return await ApiClient().request(
        url:
            "$domain/public/find?idUser=${idShip}&startTime=${createTime.toIso8601String()}&endTime=${endTime.toIso8601String()}",
        // data: json.encode(data),
        method: ApiClient.post);
  }
  static Future<ApiResponse> getLocationNew(
      int idShip) async {
    return await ApiClient().request(
        url:
            "$domain/public/find?idUser=${idShip}&startTime=${createTime.toIso8601String()}&endTime=${endTime.toIso8601String()}",
        // data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> delete(int id) async {
    return await ApiClient().request(
        url: "$domain/admin/ship/delete/${id}",
        // data: json.encode(data),
        method: ApiClient.delete);
  }

  //register
  static Future<ApiResponse> userRegister(
    String name,
    String phone,
    String password,
    String email,
    DateTime dob,
    String address,
    String company,
    String role,
    int hasShip,
    String level,
    String nickName,
    String ava,
  ) async {
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "password": password,
      "email": email,
      "dob": dob.toIso8601String(),
      "address": address,
      "company": company,
      "role": role,
      "has_ship": hasShip,
      "level": level,
      "nickName": nickName,
      "ava": ava,
    };
    return await ApiClient().request(
        url: "$domain/auth/register",
        data: json.encode(data),
        method: ApiClient.post);
  }

  //send-verify-password
  static Future<ApiResponse> sendVerifyPassword(String email) async {
    Map data = {"email": email};
    return await ApiClient().request(
        url: "$domain/api/v1/auth/send-verify/reset-password",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> getDetail(int id) async {
    return await ApiClient()
        .request(url: "$domain/admin/ship/${id}", method: ApiClient.get);
  }

  //verify-password
  static Future<ApiResponse> verifyPassword(
      {required String email, required String code}) async {
    Map data = {"email": email, "code": code};
    return await ApiClient().request(
        url: "$domain/api/v1/auth/verify/reset-password",
        data: json.encode(data),
        method: ApiClient.post);
  }

  static Future<ApiResponse> createShip({
    required String name,
    required String typeShip,
    required String registry,
    required String imo,
    required String phone,
    required String portRegistry,
    required String nationality,
    required DateTime dob,
    required int quantityCrew,
    required int idCaptain,
    required String ava,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'typeShip': typeShip,
      'regestry': registry,
      'imo': imo,
      'phone': phone,
      'portRegestry': portRegistry,
      'nationaly': nationality,
      'dob': dob.toIso8601String(),
      'quantityCrew': quantityCrew,
      'idCaptain': idCaptain,
      'ava': ava,
    };

    return await ApiClient().request(
      url: '$domain/admin/ship/create',
      data: json.encode(data),
      method: ApiClient.post,
    );
  }

  static Future<ApiResponse> update({
    required int id,
    required String name,
    required String typeShip,
    required String registry,
    required String imo,
    required String phone,
    required String portRegistry,
    required String nationality,
    required DateTime dob,
    required int quantityCrew,
    required int idCaptain,
    required String ava,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'typeShip': typeShip,
      'regestry': registry,
      'imo': imo,
      'phone': phone,
      'portRegestry': portRegistry,
      'nationaly': nationality,
      'dob': dob.toIso8601String(),
      'quantityCrew': quantityCrew,
      'idCaptain': idCaptain,
      'ava': ava,
    };

    return await ApiClient().request(
      url: '$domain/admin/ship/update/${id}',
      data: json.encode(data),
      method: ApiClient.put,
    );
  }

  //reset-password
  static Future<ApiResponse> resetPass(
      {required String password,
      required String confirmPassword,
      required String token}) async {
    Map data = {"password": password, "confirmPassword": confirmPassword};
    return await ApiClient().request(
        url: "$domain/api/v1/auth/reset-password/$token",
        data: json.encode(data),
        method: ApiClient.post);
  }

  //profile
  static Future<ApiResponse> getUserInfo() async {
    return await ApiClient()
        .request(url: "$domain/api/v1/user/account", method: ApiClient.get);
  }

  static Future<ApiResponse> getListUserService() async {
    return await ApiClient().request(
        url: "$domain/admin/user/list?role=SERVICE", method: ApiClient.get);
  }

  static Future<ApiResponse> getListUserSailor() async {
    return await ApiClient().request(
        url: "$domain/admin/user/list?role=SAILOR", method: ApiClient.get);
  }

  static Future<ApiResponse> deleteUser(int id) async {
    return await ApiClient().request(
        url: "$domain/admin/user/delete/${id}", method: ApiClient.delete);
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
