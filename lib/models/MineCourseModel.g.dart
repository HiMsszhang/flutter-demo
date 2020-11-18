// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MineCourseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MineCourseModel _$MineCourseModelFromJson(Map<String, dynamic> json) {
  return MineCourseModel()
    ..total = json['total'] as int ?? 0
    ..perPage = json['perPage'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : MineCourseListModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$MineCourseModelToJson(MineCourseModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'perPage': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

MineCourseListModel _$MineCourseListModelFromJson(Map<String, dynamic> json) {
  return MineCourseListModel()
    ..courseId = json['course_id'] as int ?? 0
    ..orderPrice = json['order_price'] as String ?? ''
    ..courseTitle = json['course_title'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..totalHours = json['total_hours'] as num ?? 0
    ..courseDifficulty = json['course_difficulty'] as num ?? 0
    ..learningTime = json['learning_time'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..status = json['status'] as num ?? 0
    ..openingTime = json['opening_time'] as String ?? '';
}

Map<String, dynamic> _$MineCourseListModelToJson(
        MineCourseListModel instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'order_price': instance.orderPrice,
      'course_title': instance.courseTitle,
      'typeface_title': instance.typefaceTitle,
      'total_hours': instance.totalHours,
      'course_difficulty': instance.courseDifficulty,
      'learning_time': instance.learningTime,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'status': instance.status,
      'opening_time': instance.openingTime,
    };
