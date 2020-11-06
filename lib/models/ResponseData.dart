import 'package:json_annotation/json_annotation.dart';

part 'ResponseData.g.dart';

@JsonSerializable()
class ResponseData {
  @JsonKey(defaultValue: 0)
  int code;
  String msg;
  var data;

  ResponseData();

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

  // 命名构造函数
  ResponseData.empty();
}
