import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/PayModel.dart';

/// 支付
class PayAPI {
  /// 支付
  static Future<DataResult> payNow({
    int courseId,
    int courseModelId,
    int paymentMethodId,
    int discountMoMoney,
    num coursePrice,
  }) async {
    try {
      var params = {
        'course_id': courseId,
        'course_model_id': courseModelId,
        'payment_method_id': paymentMethodId,
        'discount_mo_money': discountMoMoney,
        'course_price': coursePrice,
      };
      Response res = await http.post('/paynow', queryParameters: params);
      var result = paymentMethodId == 1 ? AliPayModel.fromJson(res.data ?? {}) : WechatPayModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 生成订单
  static Future<DataResult> order({
    int courseId,
  }) async {
    try {
      var params = {
        'course_id': courseId,
      };
      Response res = await http.post('/buynow', queryParameters: params);
      return DataResult(OrderModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
