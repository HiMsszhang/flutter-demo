import 'package:dio/dio.dart';
import 'package:molan_edu/models/CourseCollectionModel.dart';
import 'package:molan_edu/models/MineCourseModel.dart';
import 'package:molan_edu/models/MineHeadMasterModel.dart';
import 'package:molan_edu/models/teacherCollectionModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

class MineApi {
  //我的收藏（课程）
  static Future<DataResult> courseCollectionlist({int page, int listRow, String courseTitle}) async {
    try {
      Map<String, dynamic> params = {'page': page, 'list_row': listRow};
      if (courseTitle != '') params['course_title'] = courseTitle;
      Response res = await http.post('/coursecollectionlist', queryParameters: params);
      var result = CourseCollectionModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //我的收藏（老师）
  static Future<DataResult> teacherCollectionList({
    int page,
    int listRow,
    String teacherName,
  }) async {
    try {
      Map<String, dynamic> params = {'page': page, 'list_row': listRow};
      if (teacherName != '') params['teacher_name'] = teacherName;

      Response res = await http.post('/teachercollectionlist', queryParameters: params);
      var result = TeacherCollectionModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //我的课程
  static Future<DataResult> mineCourseList({
    int page,
    int listRow,
    String courseTitle,
  }) async {
    try {
      Map<String, dynamic> params = {'page': page, 'list_row': listRow};
      if (courseTitle != '') params['course_title'] = courseTitle;
      Response res = await http.post('/mycourselist', queryParameters: params);
      var result = MineCourseModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //我的班主任
  static Future<DataResult> mineHeadMasterList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {'page': page, 'list_row': listRow};
      Response res = await http.post('/myclassteacherlist', queryParameters: params);
      var result = MineHeadMasterModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //我的班主任-评价及修改评价
  static Future<DataResult> mineHeadTeacherEvaluate({
    int courseId,
    int classTeacherId,
    double evaluate,
    String content,
  }) async {
    try {
      var params = {
        'course_id': courseId,
        'class_teacher_id': classTeacherId,
        'evaluate': evaluate,
        'content': content,
      };
      Response res = await http.post('/myclassteacherevaluate', queryParameters: params);

      return DataResult(res, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //老师收藏及取消收藏
  static Future<DataResult> teacherCollection({
    int teacherId,
  }) async {
    try {
      var params = {
        'teacher_id': teacherId,
      };
      Response res = await http.post('/teachercollection', queryParameters: params);
      return DataResult(res, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  //学员注销
  static Future<DataResult> cancelLation() async {
    try {
      Response res = await http.post('/cancellation');
      return DataResult(res, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
