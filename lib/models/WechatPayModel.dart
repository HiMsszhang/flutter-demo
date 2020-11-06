import 'package:json_annotation/json_annotation.dart';

part 'WechatPayModel.g.dart';

@JsonSerializable()
class WechatPayModel {
  String appid;
  String partnerid;
  String prepayid;
  String timestamp;
  String noncestr;
  String package;
  String sign;

  WechatPayModel();

  //反序列化
  factory WechatPayModel.fromJson(Map<String, dynamic> json) => _$WechatPayModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$WechatPayModelToJson(this);

  WechatPayModel.empty();
}
