// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GroupModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceModel _$ExperienceModelFromJson(Map<String, dynamic> json) {
  return ExperienceModel()
    ..id = json['id'] as int
    ..courseTitle = json['course_title'] as String ?? ''
    ..courseIntroduct = json['course_introduct'] as String ?? ''
    ..totalHours = json['total_hours'] as num ?? 0
    ..courseCateTitle = json['course_cate_title'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..learnNum = json['learn_num'] as num ?? 0
    ..duration = json['duration'] as num ?? 0;
}

Map<String, dynamic> _$ExperienceModelToJson(ExperienceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_title': instance.courseTitle,
      'course_introduct': instance.courseIntroduct,
      'total_hours': instance.totalHours,
      'course_cate_title': instance.courseCateTitle,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'typeface_title': instance.typefaceTitle,
      'learn_num': instance.learnNum,
      'duration': instance.duration,
    };

ExperienceModelListResp _$ExperienceModelListRespFromJson(
    Map<String, dynamic> json) {
  return ExperienceModelListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : ExperienceModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$ExperienceModelListRespToJson(
        ExperienceModelListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };
