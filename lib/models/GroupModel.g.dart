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

GroupCourseModel _$GroupCourseModelFromJson(Map<String, dynamic> json) {
  return GroupCourseModel()
    ..id = json['id'] as int
    ..courseTitle = json['course_title'] as String ?? ''
    ..totalHours = json['total_hours'] as num ?? 0
    ..learningTime = json['learning_time'] as String ?? ''
    ..dailyUpdate = json['daily_update'] as num ?? 0
    ..courseDifficulty = json['course_difficulty'] as num ?? 0
    ..courseDifficultyDesc = json['course_difficulty_desc'] as String ?? ''
    ..coursePrice = json['course_price'] as String ?? ''
    ..courseCateTitle = json['course_cate_title'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..image = json['image'] as String ?? ''
    ..evaluate = json['evaluate'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..learnNum = json['learn_num'] as num ?? 0
    ..marketPrice = json['market_price'] as String ?? ''
    ..openingTime = json['opening_time'] as String ?? ''
    ..teacherLabel =
        (json['teacher_label'] as List)?.map((e) => e as String)?.toList() ??
            [];
}

Map<String, dynamic> _$GroupCourseModelToJson(GroupCourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_title': instance.courseTitle,
      'total_hours': instance.totalHours,
      'learning_time': instance.learningTime,
      'daily_update': instance.dailyUpdate,
      'course_difficulty': instance.courseDifficulty,
      'course_difficulty_desc': instance.courseDifficultyDesc,
      'course_price': instance.coursePrice,
      'course_cate_title': instance.courseCateTitle,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'image': instance.image,
      'evaluate': instance.evaluate,
      'typeface_title': instance.typefaceTitle,
      'learn_num': instance.learnNum,
      'market_price': instance.marketPrice,
      'opening_time': instance.openingTime,
      'teacher_label': instance.teacherLabel,
    };

GroupCourseListResp _$GroupCourseListRespFromJson(Map<String, dynamic> json) {
  return GroupCourseListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : GroupCourseModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$GroupCourseListRespToJson(
        GroupCourseListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

GroupCourseDetailModel _$GroupCourseDetailModelFromJson(
    Map<String, dynamic> json) {
  return GroupCourseDetailModel()
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
    ..learnNum = json['learn_num'] as num ?? 0
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..currentHours = json['current_hours'] as Map<String, dynamic> ?? {}
    ..marketPrice = json['market_price'] as String ?? ''
    ..openingTime = json['opening_time'] as String ?? '';
}

Map<String, dynamic> _$GroupCourseDetailModelToJson(
        GroupCourseDetailModel instance) =>
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
      'learn_num': instance.learnNum,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'typeface_title': instance.typefaceTitle,
      'current_hours': instance.currentHours,
      'market_price': instance.marketPrice,
      'opening_time': instance.openingTime,
    };
