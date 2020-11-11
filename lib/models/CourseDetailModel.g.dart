// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) {
  return CourseDetailModel()
    ..courseIateId = json['course_cate_id'] as num ?? 0
    ..courseTitle = json['course_title'] as String ?? ''
    ..typefaceId = json['typeface_id'] as num ?? 0
    ..courseDesc = json['course_desc'] as String ?? ''
    ..curriculumPlanning = json['curriculum_planning'] as String ?? ''
    ..learningTime = json['learning_time'] as String ?? ''
    ..dailyUpdate = json['daily_update'] as num ?? 0
    ..totalHours = json['total_hours'] as num ?? 0
    ..courseDifficulty = json['course_difficulty'] as num ?? 0
    ..courseDifficultyDesc = json['course_difficulty_desc'] as String ?? ''
    ..coursePrice = json['course_price'] as String ?? ''
    ..courseCateTitle = json['course_cate_title'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..currentHours = json['current_hours'] as Map<String, dynamic> ?? {};
}

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
    <String, dynamic>{
      'course_cate_id': instance.courseIateId,
      'course_title': instance.courseTitle,
      'typeface_id': instance.typefaceId,
      'course_desc': instance.courseDesc,
      'curriculum_planning': instance.curriculumPlanning,
      'learning_time': instance.learningTime,
      'daily_update': instance.dailyUpdate,
      'total_hours': instance.totalHours,
      'course_difficulty': instance.courseDifficulty,
      'course_difficulty_desc': instance.courseDifficultyDesc,
      'course_price': instance.coursePrice,
      'course_cate_title': instance.courseCateTitle,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'typeface_title': instance.typefaceTitle,
      'current_hours': instance.currentHours,
    };
