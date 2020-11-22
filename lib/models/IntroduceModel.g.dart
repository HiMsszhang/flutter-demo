// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IntroduceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntroduceModel _$IntroduceModelFromJson(Map<String, dynamic> json) {
  return IntroduceModel()
    ..id = json['id'] as int
    ..title = json['title'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..videoUrl = json['video_url'] as String ?? ''
    ..visiteNum = json['visite_num'] as num ?? 0;
}

Map<String, dynamic> _$IntroduceModelToJson(IntroduceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'video_url': instance.videoUrl,
      'visite_num': instance.visiteNum,
    };

IntroduceListResp _$IntroduceListRespFromJson(Map<String, dynamic> json) {
  return IntroduceListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : IntroduceModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$IntroduceListRespToJson(IntroduceListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };
