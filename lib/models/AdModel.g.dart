// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdModel _$AdModelFromJson(Map<String, dynamic> json) {
  return AdModel()
    ..id = json['id'] as int
    ..advertCateId = json['advert_cate_id'] as num ?? 0
    ..advertTitle = json['advert_title'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..url = json['url'] as String ?? '';
}

Map<String, dynamic> _$AdModelToJson(AdModel instance) => <String, dynamic>{
      'id': instance.id,
      'advert_cate_id': instance.advertCateId,
      'advert_title': instance.advertTitle,
      'image': instance.image,
      'url': instance.url,
    };
