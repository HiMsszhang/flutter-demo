import 'package:dio/dio.dart';
import 'package:molan_edu/models/CopyBookModel.dart';
import 'package:molan_edu/utils/net/http.dart';
import 'result.dart';

/// 字帖
class CopybookAPI {
  /// 字帖列表
  static Future<DataResult> bookList({
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/copybooklist', queryParameters: params);
      return DataResult(CopyBookListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 获取字帖设置
  static Future<DataResult> getSetting() async {
    try {
      Response res = await http.post('/getcopybooksetting');
      return DataResult(CopyBookSettingModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 字帖设置
  static Future<DataResult> updateSetting({
    ///资源设置(1原帖2精修)
    int resource,

    ///排版设置(1单列显示2双列显示3三列显示)
    int typesetting,

    ///字体颜色(1黑色2金色3红色4白色)
    int fontColor,
  }) async {
    try {
      var params = {
        'resource': resource,
        'typesetting': typesetting,
        'font_color': fontColor,
      };
      Response res = await http.post('/copybooksetting', queryParameters: params);
      return DataResult(res.data ?? {}, true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 字帖详情
  static Future<DataResult> detail({
    int copybookId,
  }) async {
    try {
      var params = {
        'copybook_id': copybookId,
      };
      Response res = await http.post('/copybookdetail', queryParameters: params);
      return DataResult(CopyBookDetailModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 字帖字列表
  static Future<DataResult> wordList({
    int copybookId,
    int fontColor,
    int page,
    int listRow,
  }) async {
    try {
      var params = {
        'copybook_id': copybookId,
        'font_color': fontColor,
        'page': page,
        'list_row': listRow,
      };
      Response res = await http.post('/copybookwordlist', queryParameters: params);
      return DataResult(CopyBookWordListResp.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 字帖字义
  static Future<DataResult> meaning({
    String word,
  }) async {
    try {
      var params = {
        'word': word,
      };
      Response res = await http.post('/copybookwordmeaning', queryParameters: params);
      return DataResult(CopyBookWordMeaningModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }

  /// 记录观看位置
  static Future<DataResult> setPosition({
    int copybookId,
    int wordId,
  }) async {
    try {
      var params = {
        'copybook_id': copybookId,
        'word_id': wordId,
      };
      Response res = await http.post('/getcopybooksetting', queryParameters: params);
      return DataResult(CopyBookSettingModel.fromJson(res.data ?? {}), true);
    } catch (e) {
      return DataResult(e, false);
    }
  }
}
