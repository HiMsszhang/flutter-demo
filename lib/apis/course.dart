import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/CourseModel.dart';

/// 课程
class CourseAPI {
  /// 课程首页列表
  static Future<DataResult> courseList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/courselist', queryParameters: params);
      return DataResult(CourseModelListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
