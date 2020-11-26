// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeacherModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherInfoModel _$TeacherInfoModelFromJson(Map<String, dynamic> json) {
  return TeacherInfoModel()
    ..isCollection = json['is_collection'] as num ?? 0
    ..totalCourseNum = json['total_course_num'] as num ?? 0
    ..teacher = json['teacher'] == null
        ? null
        : TeacherModel.fromJson(json['teacher'] as Map<String, dynamic>)
    ..course = (json['course'] as List)
        ?.map((e) => e == null
            ? null
            : TeacherCourseModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TeacherInfoModelToJson(TeacherInfoModel instance) =>
    <String, dynamic>{
      'is_collection': instance.isCollection,
      'total_course_num': instance.totalCourseNum,
      'teacher': instance.teacher,
      'course': instance.course,
    };

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) {
  return TeacherModel()
    ..id = json['id'] as int
    ..teacherName = json['teacher_name'] as String ?? ''
    ..teacherId = json['teacher_id'] as int ?? 0
    ..avatar = json['avatar'] as String ?? ''
    ..gender = json['gender'] as num ?? 0
    ..likeability = json['likeability'] as num ?? 0
    ..introduce = json['introduce'] as String ?? ''
    ..teacherLabel =
        (json['teacher_label'] as List)?.map((e) => e as String)?.toList() ??
            [];
}

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacher_name': instance.teacherName,
      'teacher_id': instance.teacherId,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'likeability': instance.likeability,
      'introduce': instance.introduce,
      'teacher_label': instance.teacherLabel,
    };

TeacherCourseModel _$TeacherCourseModelFromJson(Map<String, dynamic> json) {
  return TeacherCourseModel()
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
    ..isSpellGroup = json['is_spell_group'] as int ?? 0;
}

Map<String, dynamic> _$TeacherCourseModelToJson(TeacherCourseModel instance) =>
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
      'is_spell_group': instance.isSpellGroup,
    };

TeacherCourseListResp _$TeacherCourseListRespFromJson(
    Map<String, dynamic> json) {
  return TeacherCourseListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : TeacherCourseModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$TeacherCourseListRespToJson(
        TeacherCourseListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

TeacherShareModel _$TeacherShareModelFromJson(Map<String, dynamic> json) {
  return TeacherShareModel()
    ..id = json['id'] as int
    ..shareTitle = json['share_title'] as String ?? ''
    ..type = json['type'] as num ?? 0
    ..image = json['image'] as String ?? ''
    ..video = json['video'] as String ?? ''
    ..visiteNum = json['visite_num'] as num ?? 0
    ..praiseNum = json['praise_num'] as num ?? 0
    ..createTime = json['create_time'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..isPraise = json['is_praise'] as num ?? 0;
}

Map<String, dynamic> _$TeacherShareModelToJson(TeacherShareModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'share_title': instance.shareTitle,
      'type': instance.type,
      'image': instance.image,
      'video': instance.video,
      'visite_num': instance.visiteNum,
      'praise_num': instance.praiseNum,
      'create_time': instance.createTime,
      'teacher_name': instance.teacherName,
      'avatar': instance.avatar,
      'is_praise': instance.isPraise,
    };

TeacherShareListResp _$TeacherShareListRespFromJson(Map<String, dynamic> json) {
  return TeacherShareListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : TeacherShareModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$TeacherShareListRespToJson(
        TeacherShareListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

RateListResp _$RateListRespFromJson(Map<String, dynamic> json) {
  return RateListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : RateModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$RateListRespToJson(RateListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

RateModel _$RateModelFromJson(Map<String, dynamic> json) {
  return RateModel()
    ..comprehensive = json['comprehensive'] as String ?? ''
    ..content = json['content'] as String ?? ''
    ..createTime = json['create_time'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..courseArrangement = json['course_arrangement'] as String ?? ''
    ..labelTitle = json['label_title'] as String ?? '';
}

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'comprehensive': instance.comprehensive,
      'content': instance.content,
      'create_time': instance.createTime,
      'name': instance.name,
      'avatar': instance.avatar,
      'course_arrangement': instance.courseArrangement,
      'label_title': instance.labelTitle,
    };

RateLabelModel _$RateLabelModelFromJson(Map<String, dynamic> json) {
  return RateLabelModel()
    ..id = json['id'] as int
    ..labelTitle = json['label_title'] as String ?? ''
    ..evaluateNum = json['evaluate_num'] as num ?? 0;
}

Map<String, dynamic> _$RateLabelModelToJson(RateLabelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label_title': instance.labelTitle,
      'evaluate_num': instance.evaluateNum,
    };

TeacherRateModel _$TeacherRateModelFromJson(Map<String, dynamic> json) {
  return TeacherRateModel()
    ..tatalEvaluateNum = json['tatal_evaluate_num'] as num ?? 0
    ..likeability = json['likeability'] as num ?? 0
    ..teacherLabel = (json['teacher_label'] as List)
            ?.map((e) => e == null
                ? null
                : RateLabelModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        []
    ..evaluateList = json['evaluate_list'] == null
        ? null
        : RateListResp.fromJson(json['evaluate_list'] as Map<String, dynamic>);
}

Map<String, dynamic> _$TeacherRateModelToJson(TeacherRateModel instance) =>
    <String, dynamic>{
      'tatal_evaluate_num': instance.tatalEvaluateNum,
      'likeability': instance.likeability,
      'teacher_label': instance.teacherLabel,
      'evaluate_list': instance.evaluateList,
    };
