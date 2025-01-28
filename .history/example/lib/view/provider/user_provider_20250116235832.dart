import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/model/UserModel.dart';


class UserProvider with ChangeNotifier {
  UserModel1? _user;

  UserModel1? get user => _user;

  void setUser(UserModel1 user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  bool isRoleService() {
    return _user?.role == 'SERVICE';
  }

  bool isRoleSailor() {
    return _user?.role == 'SAILOR';
  }
}
