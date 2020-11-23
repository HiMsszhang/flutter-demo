import 'package:json_annotation/json_annotation.dart';
part 'ConfigModel.g.dart';

@JsonSerializable()
class ConfigModel {
  @JsonKey(defaultValue: '')
  String value;
  ConfigModel();

  //反序列化
  factory ConfigModel.fromJson(Map<String, dynamic> json) => _$ConfigModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);

  ConfigModel.empty();
}
