import 'package:json_annotation/json_annotation.dart';

part 'CourseFilterModel.g.dart';

@JsonSerializable()
class CourseFilterModel {
  /// 字体列表
  @JsonKey(defaultValue: [])
  List<CourseFilterItemModel> typeface;

  /// 性别列表
  @JsonKey(defaultValue: [])
  List<CourseFilterItemModel> gender;

  /// 老师性格列表
  @JsonKey(name: 'teacher_character', defaultValue: [])
  List<CourseFilterItemModel> teacherCharacter;

  /// 老师资质列表
  @JsonKey(name: 'teacher_qualifications', defaultValue: [])
  List<CourseFilterItemModel> teacherQualifications;

  /// 老师证书等级列表
  @JsonKey(name: 'teacher_certificate', defaultValue: [])
  List<CourseFilterItemModel> teacherCertificate;

  /// 老师教龄列表
  @JsonKey(name: 'teacher_teaching_years', defaultValue: [])
  List<CourseFilterItemModel> teacherTeachingYears;

  CourseFilterModel();

  //反序列化
  factory CourseFilterModel.fromJson(Map<String, dynamic> json) => _$CourseFilterModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseFilterModelToJson(this);

  CourseFilterModel.empty();
}

@JsonSerializable()
class CourseFilterItemModel {
  num id;

  @JsonKey(defaultValue: '')
  String title;

  CourseFilterItemModel();

  //反序列化
  factory CourseFilterItemModel.fromJson(Map<String, dynamic> json) => _$CourseFilterItemModelFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CourseFilterItemModelToJson(this);

  CourseFilterItemModel.empty();
}
