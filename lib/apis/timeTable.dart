import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';
import 'package:molan_edu/models/TimeTableModel.dart';

/// 课程表
class TimeTableAPI {
  /// 课程表列表
  static Future<DataResult> list({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/courseorderlist', queryParameters: params);
      return DataResult(TimeTableListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
