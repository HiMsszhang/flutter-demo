// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConfigModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigArticleModel _$ConfigArticleModelFromJson(Map<String, dynamic> json) {
  return ConfigArticleModel()
    ..title = json['title'] as String ?? ''
    ..content = json['content'] as String ?? '';
}

Map<String, dynamic> _$ConfigArticleModelToJson(ConfigArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
