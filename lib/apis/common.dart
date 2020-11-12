import 'package:dio/dio.dart';
import 'package:molan_edu/models/AdModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

/// 公共
class CommonAPI {
  /// 短信验证码
  static Future<DataResult> getCode({
    String mobile,
  }) async {
    try {
      var params = {
        'mobile': mobile,
      };
      Response res = await http.post('/send', queryParameters: params);
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 广告列表
  static Future<DataResult> adList({
    int advertCateId,
  }) async {
    try {
      var params = {
        'advert_cate_id': advertCateId,
      };
      Response res = await http.post('/advertlist', queryParameters: params);
      List<AdModel> result = [];
      for (var item in res.data) {
        item = AdModel.fromJson(item ?? {});
        result.add(item);
      }
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
