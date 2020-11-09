// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatPayModel _$WechatPayModelFromJson(Map<String, dynamic> json) {
  return WechatPayModel()
    ..appid = json['appid'] as String
    ..partnerid = json['partnerid'] as String
    ..prepayid = json['prepayid'] as String
    ..timestamp = json['timestamp'] as String
    ..noncestr = json['noncestr'] as String
    ..package = json['package'] as String
    ..sign = json['sign'] as String;
}

Map<String, dynamic> _$WechatPayModelToJson(WechatPayModel instance) =>
    <String, dynamic>{
      'appid': instance.appid,
      'partnerid': instance.partnerid,
      'prepayid': instance.prepayid,
      'timestamp': instance.timestamp,
      'noncestr': instance.noncestr,
      'package': instance.package,
      'sign': instance.sign,
    };

AliPayModel _$AliPayModelFromJson(Map<String, dynamic> json) {
  return AliPayModel()..sign = json['sign'] as String;
}

Map<String, dynamic> _$AliPayModelToJson(AliPayModel instance) =>
    <String, dynamic>{
      'sign': instance.sign,
    };
