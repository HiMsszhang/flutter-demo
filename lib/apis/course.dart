import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';
import 'package:molan_edu/models/CourseModel.dart';

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

  //课程详情
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

<<<<<<< HEAD
  //课程目录列表
  static Future<DataResult> coursecataloguelist({int courseId, int page, int listRow}) async {
    try {
      var params = {
        'course_id': courseId,
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/coursecataloguelist', queryParameters: params);
      var result = CourseCataloguelistModleListResp.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //课程相关推荐
  static Future<DataResult> courserecommendlist({int courseCateId, int typefaceId}) async {
    try {
      Map<String, int> params = {
        'course_cate_id': courseCateId,
        'typeface_id': typefaceId,
      };
      Response res = await http.post('/courserecommendlist', queryParameters: params);
      var result = CourseRecommendModle.fromJson(res.data ?? []);
=======
  /// 最新课程列表
  static Future<DataResult> newCourseList() async {
    try {
      Response res = await http.post('/newcourselist');
      List<CourseModel> result = [];
      for (var item in res.data) {
        item = CourseModel.fromJson(item ?? {});
        result.add(item);
      }
>>>>>>> 188876be9c72bf8c8e6e211caa97d1e1f152f519
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
