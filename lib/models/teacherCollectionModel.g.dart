// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacherCollectionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherCollectionListModel _$TeacherCollectionListModelFromJson(
    Map<String, dynamic> json) {
  return TeacherCollectionListModel()
    ..teacherId = json['teacher_id'] as num ?? 0
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..introduce = json['introduce'] as String ?? ''
    ..likeability = json['likeability'] as num ?? 0;
}

Map<String, dynamic> _$TeacherCollectionListModelToJson(
        TeacherCollectionListModel instance) =>
    <String, dynamic>{
      'teacher_id': instance.teacherId,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'introduce': instance.introduce,
      'likeability': instance.likeability,
    };

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
                : TeacherCollectionListModel.fromJson(
                    e as Map<String, dynamic>))
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
