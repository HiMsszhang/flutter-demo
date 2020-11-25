// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CopyBookModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CopyBookModel _$CopyBookModelFromJson(Map<String, dynamic> json) {
  return CopyBookModel()
    ..id = json['id'] as int
    ..copybookTitle = json['copybook_title'] as String ?? ''
    ..wordNum = json['word_num'] as num ?? 0
    ..image = json['image'] as String ?? ''
    ..lastWordId = json['last_word_id'] as num ?? 0
    ..sn = json['sn'] as num ?? 0;
}

Map<String, dynamic> _$CopyBookModelToJson(CopyBookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'copybook_title': instance.copybookTitle,
      'word_num': instance.wordNum,
      'image': instance.image,
      'last_word_id': instance.lastWordId,
      'sn': instance.sn,
    };

CopyBookListResp _$CopyBookListRespFromJson(Map<String, dynamic> json) {
  return CopyBookListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : CopyBookModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$CopyBookListRespToJson(CopyBookListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

CopyBookSettingModel _$CopyBookSettingModelFromJson(Map<String, dynamic> json) {
  return CopyBookSettingModel()
    ..resource = json['resource'] as num ?? 0
    ..typesetting = json['typesetting'] as num ?? 0
    ..fontColor = json['font_color'] as num ?? 0
    ..lastWordId = json['last_word_id'] as num ?? 0
    ..sn = json['sn'] as num ?? 0
    ..totalWordNum = json['total_word_num'] as num ?? 0
    ..copybookId = json['copybook_id'] as num ?? 0;
}

Map<String, dynamic> _$CopyBookSettingModelToJson(
        CopyBookSettingModel instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'typesetting': instance.typesetting,
      'font_color': instance.fontColor,
      'last_word_id': instance.lastWordId,
      'sn': instance.sn,
      'total_word_num': instance.totalWordNum,
      'copybook_id': instance.copybookId,
    };

CopyBookDetailModel _$CopyBookDetailModelFromJson(Map<String, dynamic> json) {
  return CopyBookDetailModel()
    ..id = json['id'] as int
    ..copybookTitle = json['copybook_title'] as String ?? ''
    ..copybookDesc = json['copybook_desc'] as String ?? ''
    ..wordNum = json['word_num'] as num ?? 0
    ..image = json['image'] as String ?? ''
    ..copybookVersion = json['copybook_version'] as String ?? ''
    ..calligrapherTitle = json['calligrapher_title'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..publisherTitle = json['publisher_title'] as String ?? ''
    ..copybookAppreciateId = json['copybook_appreciate_id'] as num ?? 0;
}

Map<String, dynamic> _$CopyBookDetailModelToJson(
        CopyBookDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'copybook_title': instance.copybookTitle,
      'copybook_desc': instance.copybookDesc,
      'word_num': instance.wordNum,
      'image': instance.image,
      'copybook_version': instance.copybookVersion,
      'calligrapher_title': instance.calligrapherTitle,
      'typeface_title': instance.typefaceTitle,
      'publisher_title': instance.publisherTitle,
      'copybook_appreciate_id': instance.copybookAppreciateId,
    };

CopyBookWordModel _$CopyBookWordModelFromJson(Map<String, dynamic> json) {
  return CopyBookWordModel()
    ..id = json['id'] as int
    ..word = json['word'] as String ?? ''
    ..shrink = json['shrink'] as String ?? ''
    ..wordNum = json['word_num'] as num ?? 0
    ..image = json['image'] as String ?? '';
}

Map<String, dynamic> _$CopyBookWordModelToJson(CopyBookWordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'shrink': instance.shrink,
      'word_num': instance.wordNum,
      'image': instance.image,
    };

CopyBookWordListResp _$CopyBookWordListRespFromJson(Map<String, dynamic> json) {
  return CopyBookWordListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : CopyBookWordModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$CopyBookWordListRespToJson(
        CopyBookWordListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

CopyBookWordMeaningModel _$CopyBookWordMeaningModelFromJson(
    Map<String, dynamic> json) {
  return CopyBookWordMeaningModel()
    ..word = json['word'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..pinyin = json['pinyin'] as String ?? ''
    ..radical = json['radical'] as String ?? ''
    ..strokeCount = json['stroke_count'] as num ?? 0
    ..traditional = json['traditional'] as String ?? '';
}

Map<String, dynamic> _$CopyBookWordMeaningModelToJson(
        CopyBookWordMeaningModel instance) =>
    <String, dynamic>{
      'word': instance.word,
      'image': instance.image,
      'pinyin': instance.pinyin,
      'radical': instance.radical,
      'stroke_count': instance.strokeCount,
      'traditional': instance.traditional,
    };
