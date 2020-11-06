// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) {
  return ResponseData()
    ..code = json['code'] as int ?? 0
    ..msg = json['msg'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
