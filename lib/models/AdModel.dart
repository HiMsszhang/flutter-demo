import 'package:json_annotation/json_annotation.dart';

part 'AdModel.g.dart';

@JsonSerializable()
class AdModel {
  /// 广告编号
  int id;

  /// 广告分类编号
  @JsonKey(name: 'advert_cate_id', defaultValue: 0)
  num advertCateId;

  /// 广告标题
  @JsonKey(name: 'advert_title', defaultValue: '')
  String advertTitle;

  /// 广告图片
  @JsonKey(defaultValue: '')
  String image;

  /// 广告链接或详情编号
  @JsonKey(name: 'url', defaultValue: '')
  String url;

  AdModel();

  //反序列化
  factory AdModel.fromJson(Map<String, dynamic> json) => _$AdModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$AdModelToJson(this);

  AdModel.empty();
}
