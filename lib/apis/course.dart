import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/models/CourseDetailModel.dart';

/// 课程
class CourseAPI {
  /// 课程首页列表
  static Future<DataResult> courseList({int page, int listRow}) async {
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

  static Future<DataResult> coursedetail({int courseId}) async {
    try {
      var params = {
        'course_id': courseId,
      };
      Response res = await http.post('/coursedetail', queryParameters: params);
      var result = CourseDetailModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 最新课程列表
  static Future<DataResult> newCourseList({int page, int listRow}) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/newcourselist', queryParameters: params);
      List<CourseModel> result = [];
      for (var item in res.data) {
        item = CourseModel.fromJson(item ?? {});
        result.add(item);
      }
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
