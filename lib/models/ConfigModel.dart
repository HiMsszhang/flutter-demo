import 'package:json_annotation/json_annotation.dart';
part 'ConfigModel.g.dart';

@JsonSerializable()
class ConfigArticleModel {
  @JsonKey(defaultValue: '')
  String title;
  @JsonKey(defaultValue: '')
  String content;
  ConfigArticleModel();

  //反序列化
  factory ConfigArticleModel.fromJson(Map<String, dynamic> json) => _$ConfigArticleModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$ConfigArticleModelToJson(this);

  ConfigArticleModel.empty();
}
