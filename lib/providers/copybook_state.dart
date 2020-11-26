import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/config/config.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/utils/local_storage.dart';

class CopybookGridItem {
  String title;
  String redImage;
  String whiteImage;
  String greenImage;
  String noneImage;
  String image;
  String type;

  CopybookGridItem({
    this.type,
    this.title,
    this.redImage,
    this.whiteImage,
    this.greenImage,
    this.noneImage,
    this.image,
  });
}

/// 纸张
class CopybookPaperItem {
  String title;
  String image;
  String type;

  CopybookPaperItem({this.title, this.image, this.type = 'none'});
}

class CopybookOption<T> {
  String title;
  int value;

  CopybookOption({this.title, this.value});
}

class CopybookState with ChangeNotifier {
  /// 网格设置list
  List<CopybookGridItem> gridItems = [
    CopybookGridItem(
      type: 'mizi',
      title: '米字格',
      image: 'mizi',
    ),
    CopybookGridItem(
      type: 'jiugong',
      title: '九宫格',
      image: 'jiugong',
    ),
    CopybookGridItem(
      type: 'huitian',
      title: '回田格',
      image: 'huitian',
    ),
    CopybookGridItem(
      type: 'huigong',
      title: '回宫格',
      image: 'huigong',
    ),
    CopybookGridItem(
      type: 'yuangong',
      title: '圆宫格',
      image: 'yuangong',
    ),
    CopybookGridItem(
      type: 'zhonggong',
      title: '中宫格',
      image: 'zhonggong',
    ),
  ];

  /// 资源设置list
  List<CopybookOption<int>> resourceList = [
    CopybookOption<int>(title: '精修', value: 2),
    CopybookOption<int>(title: '原帖', value: 1),
//    CopybookOption<int>(title: '对比', value: 3),
  ];

  /// 排版设置list
  List<CopybookOption<int>> composeList = [
    CopybookOption<int>(title: '单列显示', value: 1),
    CopybookOption<int>(title: '双列显示', value: 2),
    CopybookOption<int>(title: '三列显示', value: 3),
  ];

  /// 字体颜色设置list
  List<CopybookOption<int>> fontColorList = [
    CopybookOption<int>(
      title: '黑色',
      value: 2,
    ),
    CopybookOption<int>(
      title: '金色',
      value: 3,
    ),
    CopybookOption<int>(
      title: '红色',
      value: 4,
    ),
    CopybookOption<int>(
      title: '白色',
      value: 5,
    ),
  ];

  /// 背景设置list
  List<CopybookPaperItem> paperList = [
    CopybookPaperItem(
      title: '无',
      image: 'none',
      type: 'none',
    ),
    CopybookPaperItem(
      title: '宣纸一',
      image: 'xuanzhi1',
      type: 'xuanzhi1',
    ),
    CopybookPaperItem(
      title: '宣纸二',
      image: 'xuanzhi2',
      type: 'xuanzhi2',
    ),
    CopybookPaperItem(
      title: '黑底白字',
      image: 'heidibaizi',
      type: 'heidibaizi',
    ),
    CopybookPaperItem(
      title: '毛边纸',
      image: 'maobianzhi',
      type: 'maobianzhi',
    ),
    CopybookPaperItem(
      title: '红纸',
      image: 'hongzhi',
      type: 'hongzhi',
    ),
    CopybookPaperItem(
      title: '黄宣',
      image: 'huangxuan',
      type: 'huangxuan',
    ),
    CopybookPaperItem(
      title: '蓝宣',
      image: 'lanxuan',
      type: 'lanxuan',
    ),
    CopybookPaperItem(
      title: '青宣',
      image: 'qingxuan',
      type: 'qingxuan',
    ),
    CopybookPaperItem(
      title: '洒金宣纸',
      image: 'jiujinxuanzhi',
      type: 'jiujinxuanzhi',
    ),
    CopybookPaperItem(
      title: '洒金黄宣',
      image: 'jiujinhuangxuan',
      type: 'jiujinhuangxuan',
    ),
    CopybookPaperItem(
      title: '洒金蓝宣',
      image: 'jiujinlanxuan',
      type: 'jiujinlanxuan',
    ),
    CopybookPaperItem(
      title: '洒金青宣',
      image: 'jiujinqingxuan',
      type: 'jiujinqingxuan',
    ),
    CopybookPaperItem(
      title: '洒金红纸',
      image: 'jiujinhongzhi',
      type: 'jiujinhongzhi',
    ),
    CopybookPaperItem(
      title: '自定义',
      image: 'custom',
      type: 'custom',
    ),
  ];

  void setConfig({
    String gridColor,
    String gridType,
    int resource,
    int compose,
    int fontColor,
    String paperType,
  }) {
    if (gridColor != null) _gridColor = gridColor;
    if (gridType != null) _gridType = gridType;
    if (resource != null) _resource = resource;
    if (compose != null) _compose = compose;
    if (fontColor != null) _fontColor = fontColor;
    if (paperType != null) _paperType = paperType;
    Future.delayed(Duration.zero, () async {
      var obj = {
        'gridColor': _gridColor,
        'gridType': _gridType,
        'resource': _resource,
        'compose': _compose,
        'fontColor': _fontColor,
        'paperType': _paperType,
        'customPaperPath': _customPaperPath,
      };
      await LocalStorage.setJSON(Config.COPYBOOK_SETTING, obj);
    });
    notifyListeners();
  }

  void setCustomPaperPath(String path) {
    _customPaperPath = path;
    notifyListeners();
  }

  Future getConfig() async {
    var obj = await LocalStorage.getJSON(Config.COPYBOOK_SETTING);
    _gridColor = obj['gridColor'];
    _gridType = obj['gridType'];
    _resource = obj['resource'];
    _compose = obj['compose'];
    _fontColor = obj['fontColor'];
    _paperType = obj['paperType'];
    _customPaperPath = obj['customPaperPath'];
    notifyListeners();
  }

  /// 网格颜色
  String _gridColor = 'red';

  String get getGridColor => _gridColor;

  /// 网格类型
  String _gridType = 'mizi';

  String get getGridType => _gridType;

  /// resource
  int _resource = 2;

  int get getResource => _resource != 1 ? _fontColor : _resource;

  /// 排版
  int _compose = 1;

  int get getCompose => _compose;

  /// 字体颜色
  int _fontColor = 2;

  int get getFontColor => _fontColor;

  /// 背景设置
  String _paperType = 'none';

  String get getPaperType => _paperType;

  /// 自定义背景路径
  String _customPaperPath;

  String get customPaperPath => _customPaperPath;

  String get getPaperPath {
    if (getPaperType != 'custom') {
      return _paperType;
    }
    return _customPaperPath;
  }
}
