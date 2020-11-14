// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseFilterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseFilterModel _$CourseFilterModelFromJson(Map<String, dynamic> json) {
  return CourseFilterModel()
    ..typeface = (json['typeface'] as List)
            ?.map((e) => e == null
                ? null
                : CourseFilterItemModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..gender =
        (json['gender'] as List)?.map((e) => e == null ? null : CourseFilterItemModel.fromJson(e as Map<String, dynamic>))?.toList() ??
            []
    ..teacherCharacter = (json['teacher_character'] as List)
            ?.map((e) => e == null
                ? null
                : CourseFilterItemModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..teacherQualifications = (json['teacher_qualifications'] as List)
            ?.map((e) => e == null ? null : CourseFilterItemModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..teacherCertificate = (json['teacher_certificate'] as List)?.map((e) => e == null ? null : CourseFilterItemModel.fromJson(e as Map<String, dynamic>))?.toList() ?? []
    ..teacherTeachingYears = (json['teacher_teaching_years'] as List)?.map((e) => e == null ? null : CourseFilterItemModel.fromJson(e as Map<String, dynamic>))?.toList() ?? [];
}

Map<String, dynamic> _$CourseFilterModelToJson(CourseFilterModel instance) =>
    <String, dynamic>{
      'typeface': instance.typeface,
      'gender': instance.gender,
      'teacher_character': instance.teacherCharacter,
      'teacher_qualifications': instance.teacherQualifications,
      'teacher_certificate': instance.teacherCertificate,
      'teacher_teaching_years': instance.teacherTeachingYears,
    };

CourseFilterItemModel _$CourseFilterItemModelFromJson(
    Map<String, dynamic> json) {
  return CourseFilterItemModel()
    ..id = json['id'] as num
    ..title = json['title'] as String ?? '';
}

Map<String, dynamic> _$CourseFilterItemModelToJson(
        CourseFilterItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
