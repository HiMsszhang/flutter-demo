import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/config/config.dart';

import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/utils/local_storage.dart';

class UserState with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel _user;

  UserModel get userInfo => _user;

  Future updateUser(UserModel user) async {
    _user = user;
    LocalStorage.setJSON(Config.S_USERINFO, user);
    LocalStorage.setJSON(Config.S_TOKEN, user.token);
    notifyListeners();
  }

  Future getUser() async {
    var userMap = await LocalStorage.getJSON(Config.S_USERINFO);
    if (userMap == null) return false;
    _user = UserModel.fromJson(userMap);
  }
}
