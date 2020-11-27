import 'package:dio/dio.dart';
import 'package:molan_edu/models/AdModel.dart';
import 'package:molan_edu/models/ConfigModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';
import 'package:http_parser/http_parser.dart';

/// 公共
class CommonAPI {
  /// 短信验证码
  static Future<DataResult> getCode({
    String mobile,
  }) async {
    try {
      var params = {
        'mobile': mobile,
      };
      Response res = await http.post('/send', queryParameters: params);
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 广告列表
  static Future<DataResult> adList({
    int advertCateId,
  }) async {
    try {
      var params = {
        'advert_cate_id': advertCateId,
      };
      Response res = await http.post('/advertlist', queryParameters: params);
      List<AdModel> result = [];
      for (var item in res.data) {
        item = AdModel.fromJson(item ?? {});
        result.add(item);
      }
      return DataResult(result, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 文件上传
  static Future<DataResult> upload({
    String path,
  }) async {
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename: name, contentType: MediaType('image', suffix)),
    });
    try {
      Response res = await http.post('/upload', data: formData);
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 获取版本信息
  static Future<DataResult> getVersion() async {
    try {
      Response res = await http.post('/version');
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 聊天记录
  static Future<DataResult> saveMessage({
    int teacherId,
    int courseId,
    String content,
  }) async {
    try {
      var params = {
        'teacher_id': teacherId,
        'content': content,
      };
      if (courseId != null) params['course_id'] = courseId;
      Response res = await http.post('/chat', queryParameters: params);
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 获取文章
  static Future<DataResult> getArticle({
    String type = 'useragreement',
  }) async {
    try {
      Response res = await http.post('/$type');
      return DataResult(ConfigArticleModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
