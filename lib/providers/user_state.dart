import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/config/config.dart';

import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/utils/local_storage.dart';

class UserState with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel _user;
  bool _hasLogin = false;

  UserModel get userInfo => _user;

  bool get hasLogin => _hasLogin;

  Future updateUser(UserModel user) async {
    _user = user;
    _hasLogin = true;
    LocalStorage.setJSON(Config.S_USERINFO, user);
    if (user.token != null && user.token != '') LocalStorage.setJSON(Config.S_TOKEN, user.token);
    notifyListeners();
  }

  Future getUser() async {
    var userMap = await LocalStorage.getJSON(Config.S_USERINFO);
    if (userMap == null) return false;
    _user = UserModel.fromJson(userMap);
    var token = await LocalStorage.getJSON(Config.S_TOKEN);
    _hasLogin = token != null ? true : false;
    notifyListeners();
  }

  Future logOut() async {
    await LocalStorage.remove(Config.S_USERINFO);
    await LocalStorage.remove(Config.S_TOKEN);
    await LocalStorage.remove(Config.IM_SIGN);
    _hasLogin = false;
    _user = UserModel.empty();
    notifyListeners();
  }
}
