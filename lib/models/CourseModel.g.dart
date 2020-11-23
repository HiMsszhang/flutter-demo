// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return CourseModel()
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
    ..learnNum = json['learn_num'] as num ?? 0;
}

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
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
    };

CourseModelListResp _$CourseModelListRespFromJson(Map<String, dynamic> json) {
  return CourseModelListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : CourseModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$CourseModelListRespToJson(
        CourseModelListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

CourseCatModel _$CourseCatModelFromJson(Map<String, dynamic> json) {
  return CourseCatModel()
    ..id = json['id'] as int
    ..courseCateTitle = json['course_cate_title'] as String ?? '';
}

Map<String, dynamic> _$CourseCatModelToJson(CourseCatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_cate_title': instance.courseCateTitle,
    };

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
    ..learnNum = json['learn_num'] as num ?? 0
    ..teacherId = json['teacher_id'] as num ?? 0
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
      'learn_num': instance.learnNum,
      'teacher_id': instance.teacherId,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'typeface_title': instance.typefaceTitle,
      'current_hours': instance.currentHours,
    };

CourseCataloguelistModle _$CourseCataloguelistModleFromJson(
    Map<String, dynamic> json) {
  return CourseCataloguelistModle()
    ..id = json['id'] as int
    ..courseCatalogueTitle = json['course_catalogue_title'] as String ?? ''
    ..courseArrangement = json['course_arrangement'] as String ?? ''
    ..url = json['url'] as String ?? ''
    ..duration = json['duration'] as num ?? '';
}

Map<String, dynamic> _$CourseCataloguelistModleToJson(
        CourseCataloguelistModle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_catalogue_title': instance.courseCatalogueTitle,
      'course_arrangement': instance.courseArrangement,
      'url': instance.url,
      'duration': instance.duration,
    };

CourseCataloguelistModleListResp _$CourseCataloguelistModleListRespFromJson(
    Map<String, dynamic> json) {
  return CourseCataloguelistModleListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : CourseCataloguelistModle.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$CourseCataloguelistModleListRespToJson(
        CourseCataloguelistModleListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

CourseRecommendModle _$CourseRecommendModleFromJson(Map<String, dynamic> json) {
  return CourseRecommendModle()
    ..id = json['id'] as int
    ..courseTitle = json['course_title'] as String ?? ''
    ..totalHours = json['total_hours'] as int ?? 0
    ..courseIntroduct = json['course_introduct'] as String ?? ''
    ..courseDifficulty = json['course_difficulty'] as int ?? 0
    ..courseDifficultyDesc = json['course_difficulty_desc'] as String ?? ''
    ..coursePrice = json['course_price'] as String ?? ''
    ..courseCateTitle = json['course_cate_title'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..evaluate = json['evaluate'] as String ?? ''
    ..typefaceTitle = json['typeface_title'] as String ?? ''
    ..learnNum = json['learn_num'] as int ?? 0;
}

Map<String, dynamic> _$CourseRecommendModleToJson(
        CourseRecommendModle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_title': instance.courseTitle,
      'total_hours': instance.totalHours,
      'course_introduct': instance.courseIntroduct,
      'course_difficulty': instance.courseDifficulty,
      'course_difficulty_desc': instance.courseDifficultyDesc,
      'course_price': instance.coursePrice,
      'course_cate_title': instance.courseCateTitle,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'evaluate': instance.evaluate,
      'typeface_title': instance.typefaceTitle,
      'learn_num': instance.learnNum,
    };

CourseCollectionOrCancelModel _$CourseCollectionOrCancelModelFromJson(
    Map<String, dynamic> json) {
  return CourseCollectionOrCancelModel()..msg = json['msg'] as String ?? '';
}

Map<String, dynamic> _$CourseCollectionOrCancelModelToJson(
        CourseCollectionOrCancelModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
    };
