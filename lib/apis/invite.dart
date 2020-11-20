import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/InviteModel.dart';

/// 邀请
class InviteAPI {
  /// 邀请信息
  static Future<DataResult> info() async {
    try {
      Response res = await http.post('/invitation');
      return DataResult(InviteInfoModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 邀请二维码
  static Future<DataResult> qrCode() async {
    try {
      Response res = await http.post('/qrcode');
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 我的邀请
  static Future<DataResult> myInvite() async {
    try {
      Response res = await http.post('/myinvitation');
      return DataResult(MyInviteModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 我的奖励
  static Future<DataResult> rewardList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/userloglist', queryParameters: params);
      return DataResult(InviteRewardListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 我的邀请列表
  static Future<DataResult> inviteList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/invitationlist', queryParameters: params);
      return DataResult(InvitePeopleListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
