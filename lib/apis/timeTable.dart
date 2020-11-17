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

  /// 课程表目录列表
  static Future<DataResult> menuList({
    int page,
    int listRow,
    int courseId,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
        'course_id': courseId,
      };
      Response res = await http.post('/courseordercataloguelist', queryParameters: params);
      return DataResult(TimeTableMenuListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 课程表目录详情
  static Future<DataResult> menuDetail({
    int courseCatalogueId,
  }) async {
    try {
      var params = {
        'course_catalogue_id': courseCatalogueId,
      };
      Response res = await http.post('/coursecataloguedetail', queryParameters: params);
      return DataResult(TimeTableMenuDetailModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 视频学习完毕
  static Future<DataResult> videoDone({
    int courseId,
    int courseCatalogueId,
  }) async {
    try {
      var params = {
        'course_id': courseId,
        'course_catalogue_id': courseCatalogueId,
      };
      Response res = await http.post('/videofinished', queryParameters: params);
      return DataResult(res, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 老师评价标签
  static Future<DataResult> teacherRateTags() async {
    try {
      Response res = await http.post('/teacherlabellist');
      List<TeacherRateModel> result = [];
      for (var item in res.data) {
        item = TeacherRateModel.fromJson(item ?? {});
        result.add(item);
      }
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 评价老师
  static Future<DataResult> rateTeacher({
    int teacherId,
    int courseId,
    int courseCatalogueId,
    int teacherAppearance,
    int teacherLiteracy,
    int curriculumArrangement,
    int comprehensive,
    int teacherLabelId,
    String content,
  }) async {
    try {
      Map<String, dynamic> params = {
        'teacher_id': teacherId,
        'course_id': courseId,
        'course_catalogue_id': courseCatalogueId,
        'teacher_appearance': teacherAppearance,
        'teacher_literacy': teacherLiteracy,
        'curriculum_arrangement': curriculumArrangement,
        'teacher_label_id': teacherLabelId,
        'comprehensive': comprehensive,
      };
      if (content != null) params['content'] = content;
      Response res = await http.post('/courseevaluate', queryParameters: params);
      return DataResult(res.data, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
