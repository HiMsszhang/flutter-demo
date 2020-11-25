import 'package:json_annotation/json_annotation.dart';
part 'CopyBookModel.g.dart';

///字帖列表
@JsonSerializable()
class CopyBookModel {
  int id;

  ///字帖标题
  @JsonKey(name: 'copybook_title', defaultValue: '')
  String copybookTitle;

  ///字帖字数
  @JsonKey(name: 'word_num', defaultValue: 0)
  num wordNum;

  @JsonKey(defaultValue: '')
  String image;

  ///最后访问字的编号
  @JsonKey(name: 'last_word_id', defaultValue: 0)
  num lastWordId;

  ///字序号
  @JsonKey(defaultValue: 0)
  num sn;

  CopyBookModel();

  //反序列化
  factory CopyBookModel.fromJson(Map<String, dynamic> json) => _$CopyBookModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookModelToJson(this);

  CopyBookModel.empty();
}

@JsonSerializable()
class CopyBookListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(name: 'per_page', defaultValue: 0)
  int perPage;
  @JsonKey(name: 'current_page', defaultValue: 0)
  int currentPage;
  @JsonKey(name: 'last_page', defaultValue: 0)
  int lastPage;
  @JsonKey(defaultValue: [])
  List<CopyBookModel> data;
  CopyBookListResp();

  //反序列化
  factory CopyBookListResp.fromJson(Map<String, dynamic> json) => _$CopyBookListRespFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookListRespToJson(this);

  CopyBookListResp.empty();
}

///字帖设置
@JsonSerializable()
class CopyBookSettingModel {
  ///资源设置
  @JsonKey(defaultValue: 0)
  num resource;

  ///排版设置
  @JsonKey(defaultValue: 0)
  num typesetting;

  @JsonKey(name: 'font_color', defaultValue: 0)
  num fontColor;

  ///最后访问字的编号
  @JsonKey(name: 'last_word_id', defaultValue: 0)
  num lastWordId;

  ///字序号
  @JsonKey(defaultValue: 0)
  num sn;

  ///字帖总字数
  @JsonKey(name: 'total_word_num', defaultValue: 0)
  num totalWordNum;

  ///字帖编号
  @JsonKey(name: 'copybook_id', defaultValue: 0)
  num copybookId;

  CopyBookSettingModel();

  //反序列化
  factory CopyBookSettingModel.fromJson(Map<String, dynamic> json) => _$CopyBookSettingModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookSettingModelToJson(this);

  CopyBookSettingModel.empty();
}

///字帖详情
@JsonSerializable()
class CopyBookDetailModel {
  int id;

  ///字帖标题
  @JsonKey(name: 'copybook_title', defaultValue: '')
  String copybookTitle;

  ///字帖描述
  @JsonKey(name: 'copybook_desc', defaultValue: '')
  String copybookDesc;

  ///字数
  @JsonKey(name: 'word_num', defaultValue: 0)
  num wordNum;

  @JsonKey(defaultValue: '')
  String image;

  ///字帖版本
  @JsonKey(name: 'copybook_version', defaultValue: '')
  String copybookVersion;

  ///书法家名称
  @JsonKey(name: 'calligrapher_title', defaultValue: '')
  String calligrapherTitle;

  ///字体标题
  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;

  ///出版方名称
  @JsonKey(name: 'publisher_title', defaultValue: '')
  String publisherTitle;

  ///字帖赏析编号
  @JsonKey(name: 'copybook_appreciate_id', defaultValue: 0)
  num copybookAppreciateId;

  CopyBookDetailModel();

  //反序列化
  factory CopyBookDetailModel.fromJson(Map<String, dynamic> json) => _$CopyBookDetailModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookDetailModelToJson(this);

  CopyBookDetailModel.empty();
}

///字帖字列表
@JsonSerializable()
class CopyBookWordModel {
  int id;

  ///字
  @JsonKey(defaultValue: '')
  String word;

  ///字缩略图
  @JsonKey(defaultValue: '')
  String shrink;

  ///总字数
  @JsonKey(name: 'word_num', defaultValue: 0)
  num wordNum;

  ///字图片
  @JsonKey(defaultValue: '')
  String image;

  CopyBookWordModel();

  //反序列化
  factory CopyBookWordModel.fromJson(Map<String, dynamic> json) => _$CopyBookWordModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookWordModelToJson(this);

  CopyBookWordModel.empty();
}

@JsonSerializable()
class CopyBookWordListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(name: 'per_page', defaultValue: 0)
  int perPage;
  @JsonKey(name: 'current_page', defaultValue: 0)
  int currentPage;
  @JsonKey(name: 'last_page', defaultValue: 0)
  int lastPage;
  @JsonKey(defaultValue: [])
  List<CopyBookWordModel> data;
  CopyBookWordListResp();

  //反序列化
  factory CopyBookWordListResp.fromJson(Map<String, dynamic> json) => _$CopyBookWordListRespFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookWordListRespToJson(this);

  CopyBookWordListResp.empty();
}

///字帖字义
@JsonSerializable()
class CopyBookWordMeaningModel {
  ///字
  @JsonKey(defaultValue: '')
  String word;

  ///字图片
  @JsonKey(defaultValue: '')
  String image;

  ///字拼音
  @JsonKey(defaultValue: '')
  String pinyin;

  ///字部首
  @JsonKey(defaultValue: '')
  String radical;

  ///字笔画
  @JsonKey(name: 'stroke_count', defaultValue: 0)
  num strokeCount;

  ///字繁体
  @JsonKey(defaultValue: '')
  String traditional;

  CopyBookWordMeaningModel();

  //反序列化
  factory CopyBookWordMeaningModel.fromJson(Map<String, dynamic> json) => _$CopyBookWordMeaningModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CopyBookWordMeaningModelToJson(this);

  CopyBookWordMeaningModel.empty();
}
