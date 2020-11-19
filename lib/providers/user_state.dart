import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/config/config.dart';

import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/utils/local_storage.dart';
import 'package:molan_edu/apis/user.dart';

class UserState with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel _user;
  bool _hasLogin = false;

  UserModel get userInfo => _user;

  bool get hasLogin => _hasLogin;

  Future updateUser(UserModel user) async {
    _hasLogin = true;
    if (user.token != null && user.token != '') LocalStorage.setJSON(Config.S_TOKEN, user.token);
    notifyListeners();
  }

  Future getLogin() async {
    var token = await LocalStorage.getJSON(Config.S_TOKEN);
    _hasLogin = token != null ? true : false;
    notifyListeners();
  }

  Future getUser() async {
    try {
      DataResult res = await UserAPI.getUser();
      if (res.result) {
        _user = res.data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  Future logOut() async {
    await LocalStorage.remove(Config.S_TOKEN);
    await LocalStorage.remove(Config.IM_SIGN);
    _hasLogin = false;
    _user = UserModel.empty();
    notifyListeners();
  }
}
