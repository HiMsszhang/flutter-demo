import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/UserModel.dart';

/// 用户
class UserAPI {
  /// 用户登录
  static Future<DataResult> login({
    String mobile,
    String code,
    String inviteCode,
  }) async {
    try {
      var params = {
        'mobile': mobile,
        'code': code,
        'invite_code': inviteCode,
      };
      Response res = await http.post('/registerorlogin', queryParameters: params);
      return DataResult(UserModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// im签名
  static Future<DataResult> imSign() async {
    try {
      Response res = await http.post('/usersign');
      return DataResult(res.data, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 修改信息
  static Future<DataResult> editUserInfo({String name, String avatar, int gender, int age}) async {
    var params = {
      'name': name,
      'avatar': avatar,
      'gender': gender,
      'age': age,
    };
    try {
      Response res = await http.post('/profile', queryParameters: params);
      return DataResult(UserModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
