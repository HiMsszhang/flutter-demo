// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimeTableModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableModel _$TimeTableModelFromJson(Map<String, dynamic> json) {
  return TimeTableModel()
    ..courseId = json['course_id'] as num ?? 0
    ..courseModelId = json['course_model_id'] as num ?? 0
    ..courseTitle = json['course_title'] as String ?? ''
    ..courseDifficulty = json['course_difficulty'] as num ?? 0
    ..learningTime = json['learning_time'] as String ?? ''
    ..dailyUpdate = json['daily_update'] as num ?? 0
    ..courseCateTitle = json['course_cate_title'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..learnedNum = json['learned_num'] as num ?? 0
    ..surplusNum = json['surplus_num'] as num ?? 0
    ..studyStatus = json['study_status'] as num ?? 0;
}

Map<String, dynamic> _$TimeTableModelToJson(TimeTableModel instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'course_model_id': instance.courseModelId,
      'course_title': instance.courseTitle,
      'course_difficulty': instance.courseDifficulty,
      'learning_time': instance.learningTime,
      'daily_update': instance.dailyUpdate,
      'course_cate_title': instance.courseCateTitle,
      'typeface_title': instance.typefaceTitle,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'learned_num': instance.learnedNum,
      'surplus_num': instance.surplusNum,
      'study_status': instance.studyStatus,
    };

TimeTableListResp _$TimeTableListRespFromJson(Map<String, dynamic> json) {
  return TimeTableListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : TimeTableModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$TimeTableListRespToJson(TimeTableListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };
