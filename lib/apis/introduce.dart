import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/IntroduceModel.dart';

/// 介绍
class IntroduceAPI {
  /// 视频列表
  static Future<DataResult> list({
    /// 1-了解墨岚 2-如何上课
    int type,
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'type': type,
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/videolist', queryParameters: params);
      return DataResult(IntroduceListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 观看视频
  static Future<DataResult> watch({
    int videoId,
  }) async {
    try {
      var params = {
        'video_id': videoId,
      };
      Response res = await http.post('/videovisite', queryParameters: params);
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
