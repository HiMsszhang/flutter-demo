import 'package:json_annotation/json_annotation.dart';

part 'GroupModel.g.dart';

@JsonSerializable()
class ExperienceModel {
  /// 课程编号
  int id;

  /// 课程标题
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;

  /// 课程简介
  @JsonKey(name: 'course_introduct', defaultValue: '')
  String courseIntroduct;

  /// 总课时
  @JsonKey(name: 'total_hours', defaultValue: 0)
  num totalHours;

  /// 课程分类标题
  @JsonKey(name: 'course_cate_title', defaultValue: '')
  String courseCateTitle;

  /// 老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  /// 老师图像
  @JsonKey(defaultValue: '')
  String avatar;

  /// 字体标题
  @JsonKey(name: 'typeface_title	', defaultValue: '')
  String typefaceTitle;

  /// 学习人数
  @JsonKey(name: 'learn_num	', defaultValue: 0)
  num learnNum;

  /// 总时长
  @JsonKey(defaultValue: 0)
  num duration;

  ExperienceModel();

  //反序列化
  factory ExperienceModel.fromJson(Map<String, dynamic> json) => _$ExperienceModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);

  ExperienceModel.empty();
}

@JsonSerializable()
class ExperienceModelListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<ExperienceModel> data;

  ExperienceModelListResp();

  factory ExperienceModelListResp.fromJson(Map<String, dynamic> json) => _$ExperienceModelListRespFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceModelListRespToJson(this);

  // 命名构造函数
  ExperienceModelListResp.empty();
}
