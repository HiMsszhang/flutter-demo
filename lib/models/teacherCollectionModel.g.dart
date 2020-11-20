// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacherCollectionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherCollectionModel _$TeacherCollectionModelFromJson(
    Map<String, dynamic> json) {
  return TeacherCollectionModel()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : TeacherModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$TeacherCollectionModelToJson(
        TeacherCollectionModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };
