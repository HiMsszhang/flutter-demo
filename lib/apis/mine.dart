import 'package:dio/dio.dart';
import 'package:molan_edu/models/CourseCollectionModel.dart';
import 'package:molan_edu/models/MineCourseModel.dart';
import 'package:molan_edu/models/teacherCollectionModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

class MineApi {
  //我的收藏（课程）
  static Future<DataResult> courseCollectionlist({
    int page,
    int listRow,
  }) async {
    try {
      var params = {'page': page, 'list_row': listRow};
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
  }) async {
    try {
      var params = {'page': page, 'list_row': listRow};
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
  }) async {
    try {
      var params = {'page': page, 'list_row': listRow};
      Response res = await http.post('/mycourselist', queryParameters: params);
      var result = MineCourseModel.fromJson(res.data ?? {});
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
