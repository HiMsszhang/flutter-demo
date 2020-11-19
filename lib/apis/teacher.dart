import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

import 'package:molan_edu/models/TeacherModel.dart';

/// 教师
class TeacherAPI {
  /// 老师信息
  static Future<DataResult> info({
    int teacherId,
  }) async {
    try {
      var params = {
        'teacher_id': teacherId,
      };
      Response res = await http.post('/teacher', queryParameters: params);
      return DataResult(TeacherInfoModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 老师课程列表
  static Future<DataResult> courseList({
    int teacherId,
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'teacher_id': teacherId,
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/teachercourselist', queryParameters: params);
      return DataResult(TeacherCourseListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 老师分享列表
  static Future<DataResult> shareList({
    int teacherId,
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'teacher_id': teacherId,
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/teachersharelist', queryParameters: params);
      return DataResult(TeacherShareListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 老师分享点赞
  static Future<DataResult> likeAction({
    int teacherShareId,
  }) async {
    try {
      var params = {
        'teacher_share_id': teacherShareId,
      };
      Response res = await http.post('/teachersharepraise', queryParameters: params);
      return DataResult(res.data, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
