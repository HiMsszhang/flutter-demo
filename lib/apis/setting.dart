import 'package:dio/dio.dart';
import 'package:molan_edu/models/ConfigModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

class SettingAPI {
  static Future<DataResult> config({String name}) async {
    try {
      var params = {
        'name': name,
      };
      Response res = await http.post('/config', queryParameters: params);
      var result = ConfigModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
