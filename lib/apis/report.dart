import 'package:dio/dio.dart';
import 'package:molan_edu/models/ReportModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

/// 我的报告
class ReportAPI {
  /// 我的报告列表
  static Future<DataResult> list({
    int courseId,
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'course_id': courseId,
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/userreportlist', queryParameters: params);
      return DataResult(MyReportListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 我的报告课程列表
  static Future<DataResult> courseList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/myuserreportcourselist', queryParameters: params);
      return DataResult(ReportCourseListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 我的报告分析
  static Future<DataResult> detail({
    int courseId,
  }) async {
    try {
      var params = {
        'course_id': courseId,
      };
      Response res = await http.post('/userreportanalysis', queryParameters: params);
      return DataResult(MyReportDetailModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
