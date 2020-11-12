import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/GroupModel.dart';

/// 拼团
class GroupAPI {
  /// 体验课列表
  static Future<DataResult> getExperienceList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/experiencecourselist', queryParameters: params);
      return DataResult(ExperienceModelListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
