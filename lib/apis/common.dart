import 'package:dio/dio.dart';
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
}
