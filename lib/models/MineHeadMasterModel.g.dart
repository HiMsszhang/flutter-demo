// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MineHeadMasterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MineHeadMasterModel _$MineHeadMasterModelFromJson(Map<String, dynamic> json) {
  return MineHeadMasterModel()
    ..total = json['total'] as int ?? 0
    ..perPage = json['perPage'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : MineHeadMasterListModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$MineHeadMasterModelToJson(
        MineHeadMasterModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'perPage': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

MineHeadMasterListModel _$MineHeadMasterListModelFromJson(
    Map<String, dynamic> json) {
  return MineHeadMasterListModel()
    ..classTeacherId = json['class_teacher_id'] as int ?? 0
    ..classTeacherName = json['class_teacher_name'] as String ?? ''
    ..courseTitle = json['course_title'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..wechat = json['wechat'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..courseId = json['course_id'] as num ?? 0;
}

Map<String, dynamic> _$MineHeadMasterListModelToJson(
        MineHeadMasterListModel instance) =>
    <String, dynamic>{
      'class_teacher_id': instance.classTeacherId,
      'class_teacher_name': instance.classTeacherName,
      'course_title': instance.courseTitle,
      'avatar': instance.avatar,
      'wechat': instance.wechat,
      'typeface_title': instance.typefaceTitle,
      'course_id': instance.courseId,
    };
