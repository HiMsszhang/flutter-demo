// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseCollectionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCollectionModel _$CourseCollectionModelFromJson(
    Map<String, dynamic> json) {
  return CourseCollectionModel()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : CourseCollectionItemModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$CourseCollectionModelToJson(
        CourseCollectionModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

CourseCollectionItemModel _$CourseCollectionItemModelFromJson(
    Map<String, dynamic> json) {
  return CourseCollectionItemModel()
    ..isBuy = json['is_buy'] as int ?? 0
    ..course = json['course'] == null
        ? null
        : Course.fromJson(json['course'] as Map<String, dynamic>) ?? {}
    ..teacher = json['teacher'] == null
        ? null
        : Teacher.fromJson(json['teacher'] as Map<String, dynamic>) ?? {};
}

Map<String, dynamic> _$CourseCollectionItemModelToJson(
        CourseCollectionItemModel instance) =>
    <String, dynamic>{
      'is_buy': instance.isBuy,
      'course': instance.course,
      'teacher': instance.teacher,
    };

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course()
    ..id = json['id'] as int
    ..courseTitle = json['course_title'] as String
    ..totalHours = json['total_hours'] as int
    ..learningTime = json['learning_time'] as String
    ..courseDifficulty = json['course_difficulty'] as int
    ..coursePrice = json['course_price'] as String
    ..typefaceTitle = json['typeface_title'] as String;
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'course_title': instance.courseTitle,
      'total_hours': instance.totalHours,
      'learning_time': instance.learningTime,
      'course_difficulty': instance.courseDifficulty,
      'course_price': instance.coursePrice,
      'typeface_title': instance.typefaceTitle,
    };

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return Teacher()
    ..id = json['id'] as int
    ..teacherName = json['teacher_name'] as String
    ..avatar = json['avatar'] as String
    ..teacherLabel =
        (json['teacher_label'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'teacher_label': instance.teacherLabel,
    };
