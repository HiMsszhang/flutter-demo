// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReportModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCourseModel _$ReportCourseModelFromJson(Map<String, dynamic> json) {
  return ReportCourseModel()
    ..courseId = json['course_id'] as num ?? 0
    ..courseTitle = json['course_title'] as String ?? '';
}

Map<String, dynamic> _$ReportCourseModelToJson(ReportCourseModel instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'course_title': instance.courseTitle,
    };

ReportCourseListResp _$ReportCourseListRespFromJson(Map<String, dynamic> json) {
  return ReportCourseListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : ReportCourseModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$ReportCourseListRespToJson(
        ReportCourseListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

MyReportModel _$MyReportModelFromJson(Map<String, dynamic> json) {
  return MyReportModel()
    ..integrity = json['integrity'] as num ?? 0
    ..neatness = json['neatness'] as num ?? 0
    ..beauty = json['beauty'] as num ?? 0
    ..image = (json['image'] as List)?.map((e) => e as String)?.toList() ?? []
    ..createTime = json['create_time'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..teacherName = json['teacher_name'] as String ?? ''
    ..courseCatalogueTitle = json['course_catalogue_title'] as String ?? ''
    ..week = json['week'] as String ?? ''
    ..evaluate = json['evaluate'] as String ?? '';
}

Map<String, dynamic> _$MyReportModelToJson(MyReportModel instance) =>
    <String, dynamic>{
      'integrity': instance.integrity,
      'neatness': instance.neatness,
      'beauty': instance.beauty,
      'image': instance.image,
      'create_time': instance.createTime,
      'name': instance.name,
      'avatar': instance.avatar,
      'teacher_name': instance.teacherName,
      'course_catalogue_title': instance.courseCatalogueTitle,
      'week': instance.week,
      'evaluate': instance.evaluate,
    };

MyReportListResp _$MyReportListRespFromJson(Map<String, dynamic> json) {
  return MyReportListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : MyReportModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$MyReportListRespToJson(MyReportListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

MyReportDetailModel _$MyReportDetailModelFromJson(Map<String, dynamic> json) {
  return MyReportDetailModel()
    ..user = json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>)
    ..totalDuration = json['total_duration'] as num ?? 0
    ..totalWordNum = json['total_word_num'] as num ?? 0
    ..totalHours = json['total_hours'] as num ?? 0
    ..totalComplete = json['total_complete'] as num ?? 0
    ..starsNum = json['stars_num'] as num ?? 0
    ..excellentNum = json['excellent_num'] as num ?? 0
    ..courseCatalogueList = (json['course_catalogue_list'] as List)
            ?.map((e) => e as String)
            ?.toList() ??
        []
    ..eveluateList =
        (json['eveluate_list'] as List)?.map((e) => e as num)?.toList() ?? [];
}

Map<String, dynamic> _$MyReportDetailModelToJson(
        MyReportDetailModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'total_duration': instance.totalDuration,
      'total_word_num': instance.totalWordNum,
      'total_hours': instance.totalHours,
      'total_complete': instance.totalComplete,
      'stars_num': instance.starsNum,
      'excellent_num': instance.excellentNum,
      'course_catalogue_list': instance.courseCatalogueList,
      'eveluate_list': instance.eveluateList,
    };
