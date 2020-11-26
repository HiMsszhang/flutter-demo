import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 网格类型
enum CopybookGridType { none, mizi, jiugong, huitian, huigong, yuangong, zhonggong }

/// 网格颜色
enum CopybookGridColor { none, red, white, green }

/// 字体颜色
enum CopybookFontColor { none, black, white, red, gold }

/// 纸张类型
enum CopybookPaperType {
  /// 无
  none,

  /// 自定义
  custom,

  /// 宣纸一
  xuanzhi1,

  /// 宣纸二
  xuanzhi2,

  /// 黑底白字
  heidibaizi,

  /// 毛边纸
  maobianzhi,

  /// 红纸
  hongzhi,

  /// 黄宣
  huangxuan,

  /// 蓝宣
  lanxuan,

  /// 青宣
  qingxuan,

  /// 洒金宣纸
  jiujinxuanzhi,

  /// 洒金黄宣
  jiujinhuangxuan,

  /// 洒金蓝宣
  jiujinlanxuan,

  /// 洒金青宣
  jiujinqingxuan,

  /// 洒金红纸
  jiujinhongzhi,
}

class CopybookGridItem {
  String title;
  String redImage;
  String whiteImage;
  String greenImage;
  String noneImage;
  String image;
  CopybookGridType type;

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
  CopybookPaperType type;

  CopybookPaperItem({this.title, this.image, this.type = CopybookPaperType.none});
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
      type: CopybookGridType.mizi,
      title: '米字格',
      image: 'mizi',
    ),
    CopybookGridItem(
      type: CopybookGridType.jiugong,
      title: '九宫格',
      image: 'jiugong',
    ),
    CopybookGridItem(
      type: CopybookGridType.huitian,
      title: '回田格',
      image: 'huitian',
    ),
    CopybookGridItem(
      type: CopybookGridType.huigong,
      title: '回宫格',
      image: 'huigong',
    ),
    CopybookGridItem(
      type: CopybookGridType.yuangong,
      title: '圆宫格',
      image: 'yuangong',
    ),
    CopybookGridItem(
      type: CopybookGridType.zhonggong,
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
      type: CopybookPaperType.none,
    ),
    CopybookPaperItem(
      title: '宣纸一',
      image: 'xuanzhi1',
      type: CopybookPaperType.xuanzhi1,
    ),
    CopybookPaperItem(
      title: '宣纸二',
      image: 'xuanzhi2',
      type: CopybookPaperType.xuanzhi2,
    ),
    CopybookPaperItem(
      title: '黑底白字',
      image: 'heidibaizi',
      type: CopybookPaperType.heidibaizi,
    ),
    CopybookPaperItem(
      title: '毛边纸',
      image: 'maobianzhi',
      type: CopybookPaperType.maobianzhi,
    ),
    CopybookPaperItem(
      title: '红纸',
      image: 'hongzhi',
      type: CopybookPaperType.hongzhi,
    ),
    CopybookPaperItem(
      title: '黄宣',
      image: 'huangxuan',
      type: CopybookPaperType.huangxuan,
    ),
    CopybookPaperItem(
      title: '蓝宣',
      image: 'lanxuan',
      type: CopybookPaperType.lanxuan,
    ),
    CopybookPaperItem(
      title: '青宣',
      image: 'qingxuan',
      type: CopybookPaperType.qingxuan,
    ),
    CopybookPaperItem(
      title: '洒金宣纸',
      image: 'jiujinxuanzhi',
      type: CopybookPaperType.jiujinxuanzhi,
    ),
    CopybookPaperItem(
      title: '洒金黄宣',
      image: 'jiujinhuangxuan',
      type: CopybookPaperType.jiujinhuangxuan,
    ),
    CopybookPaperItem(
      title: '洒金蓝宣',
      image: 'jiujinlanxuan',
      type: CopybookPaperType.jiujinlanxuan,
    ),
    CopybookPaperItem(
      title: '洒金青宣',
      image: 'jiujinqingxuan',
      type: CopybookPaperType.jiujinqingxuan,
    ),
    CopybookPaperItem(
      title: '洒金红纸',
      image: 'jiujinhongzhi',
      type: CopybookPaperType.jiujinhongzhi,
    ),
    CopybookPaperItem(
      title: '自定义',
      image: 'custom',
      type: CopybookPaperType.custom,
    ),
  ];

  void setConfig({
    CopybookGridColor gridColor,
    CopybookGridType gridType,
    int resource,
    int compose,
    int fontColor,
    CopybookPaperType paperType,
  }) {
    if (gridColor != null) _gridColor = gridColor;
    if (gridType != null) _gridType = gridType;
    if (resource != null) _resource = resource;
    if (compose != null) _compose = compose;
    if (fontColor != null) _fontColor = fontColor;
    if (paperType != null) _paperType = paperType;
    notifyListeners();
  }

  void setCustomPaperPath(String path) {
    customPaperPath = path;
    notifyListeners();
  }

  Map get getConfig {
    return {
      'gridColor': _gridColor,
      'gridType': _gridType,
      'resource': _resource,
      'compose': _compose,
      'fontColor': _fontColor,
      'paperType': _paperType,
      'customPaperPath': customPaperPath,
    };
  }

  /// 网格颜色
  CopybookGridColor _gridColor = CopybookGridColor.red;

  CopybookGridColor get getGridColor => _gridColor;

  String get getGridColorStr => _gridColor.toString().split('.')[1];

  /// 网格类型
  CopybookGridType _gridType = CopybookGridType.mizi;

  CopybookGridType get getGridType => _gridType;

  String get getGridTypeStr => _gridType.toString().split('.')[1];

  /// resource
  int _resource = 2;

  int get getResource => _resource != 1 ? _fontColor : _resource;

  /// 排版
  int _compose = 1;

  int get getCompose => _compose;

  /// 字体颜色
  int _fontColor = 2;

  int get getFontColor => _fontColor;

  String get getFontColorStr => _fontColor.toString().split('.')[1];

  /// 背景设置
  CopybookPaperType _paperType = CopybookPaperType.none;

  CopybookPaperType get getPaperType => _paperType;

  String get getPaperTypeStr => _paperType.toString().split('.')[1];

  /// 自定义背景路径
  String customPaperPath;

  String get getPaperPath {
    if (getPaperType != CopybookPaperType.custom) {
      return getPaperTypeStr;
    }
    return customPaperPath;
  }
}
