import 'package:dio/dio.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/models/CourseFilterModel.dart';

/// 课程
class CourseAPI {
  /// 课程首页列表
  static Future<DataResult> courseList({
    int page,
    int listRow,

    /// 课程分类编号
    int courseCateId,

    /// 课程名称
    String courseTitle,

    /// 字体编号
    int typefaceId,

    ///老师性别
    int gender,

    ///老师性格编号
    int teacherCharacterId,

    ///老师资质编号
    int teacherQualificationsId,

    ///老师证书等级编号
    int teacherCertificateId,

    ///老师教龄
    int teacherTeachingYearsId,
  }) async {
    try {
      Map<String, dynamic> params = {
        'page': page,
        'list_row': listRow,
      };
      if (courseCateId != null) params['course_cate_id'] = courseCateId;
      if (courseTitle != null) params['course_title'] = courseTitle;
      if (typefaceId != null) params['typeface_id'] = typefaceId;
      if (gender != null) params['gender'] = gender;
      if (teacherCharacterId != null) params['teacher_character_id'] = teacherCharacterId;
      if (teacherQualificationsId != null) params['teacher_qualifications_id'] = teacherQualificationsId;
      if (teacherCertificateId != null) params['teacher_certificate_id'] = teacherCertificateId;
      if (teacherTeachingYearsId != null) params['teacher_teaching_years_id'] = teacherTeachingYearsId;
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
      List<CourseRecommendModle> result = [];
      for (var item in res.data) {
        item = CourseRecommendModle.fromJson(item ?? {});
        result.add(item);
      }
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 最新课程列表
  static Future<DataResult> newCourseList() async {
    try {
      Response res = await http.post('/newcourselist');
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

  /// 课程分类列表
  static Future<DataResult> courseCatList() async {
    var params = {
      'page': 1,
      'list_row': 50,
    };
    try {
      Response res = await http.post('/coursecatelist', queryParameters: params);
      List<CourseCatModel> result = [];
      for (var item in res.data['data']) {
        item = CourseCatModel.fromJson(item ?? {});
        result.add(item);
      }
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 课程筛选列表
  static Future<DataResult> courseFilterList() async {
    try {
      Response res = await http.post('/courseselection');
      return DataResult(CourseFilterModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 未搜索结果时返回课程列表
  static Future<DataResult> courseNoResult() async {
    try {
      Response res = await http.post('/topcourselist');
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

  /// 热门搜索标签
  static Future<DataResult> hotTags() async {
    try {
      Response res = await http.post('/topsearchlist');
      return DataResult(res.data, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //课程收藏及取消
  static Future<DataResult> courseCollection({
    int courseId,
  }) async {
    try {
      Map<String, int> params = {
        'course_id': courseId,
      };
      Response res = await http.post('/coursecollection', queryParameters: params);
      var result = CourseCollectionOrCancelModel.fromJson(res ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
