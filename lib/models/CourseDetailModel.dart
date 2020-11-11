import 'package:json_annotation/json_annotation.dart';

part 'CourseDetailModel.g.dart';

@JsonSerializable()
class CourseDetailModel {
  //课程分类编号
  @JsonKey(name: "course_cate_id", defaultValue: 0)
  num courseIateId;

  //课程标题
  @JsonKey(name: "course_title", defaultValue: '')
  String courseTitle;

  //字体编号
  @JsonKey(name: "typeface_id", defaultValue: 0)
  num typefaceId;

  //课程简介
  @JsonKey(name: "course_desc", defaultValue: '')
  String courseDesc;

  //课程规划
  @JsonKey(name: "curriculum_planning", defaultValue: '')
  String curriculumPlanning;

  //学习时间
  @JsonKey(name: "learning_time", defaultValue: '')
  String learningTime;

  //日更新课时数
  @JsonKey(name: "daily_update", defaultValue: 0)
  num dailyUpdate;

  //总课时
  @JsonKey(name: "total_hours", defaultValue: 0)
  num totalHours;

  //课程难度
  @JsonKey(name: "course_difficulty", defaultValue: 0)
  num courseDifficulty;

  //课程难度描述
  @JsonKey(name: "course_difficulty_desc", defaultValue: '')
  String courseDifficultyDesc;

  //课程价格
  @JsonKey(name: "course_price", defaultValue: '')
  String coursePrice;

  //课程分类标题
  @JsonKey(name: "course_cate_title", defaultValue: '')
  String courseCateTitle;

  //老师名称
  @JsonKey(name: "teacher_name", defaultValue: '')
  String teacherName;

  //老师图像
  @JsonKey(defaultValue: '')
  String avatar;

  //字体标题
  @JsonKey(name: "typeface_title", defaultValue: '')
  String typefaceTitle;

  @JsonKey(name: 'current_hours', defaultValue: {})
  Map currentHours;

  CourseDetailModel();

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) => _$CourseDetailModelFromJson(json);

//序列化
  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);

  // CourseDetailModel.empty();
}

// @JsonSerializable()
// class CourseDetailVedio {
//   //课程目录编号
//   @JsonKey(defaultValue: 0)
//   num id;

//   //视频地址
//   @JsonKey(defaultValue: '')
//   String url;

//   //视频时长（秒）
//   @JsonKey(defaultValue: 0)
//   num duration;

//   CourseDetailVedio();

//   factory CourseDetailVedio.fromJson(Map<String, dynamic> json) => _$CourseDetailVedioFromJson(json);
// //序列化
//   Map<String, dynamic> toJson() => _$CourseDetailVedioToJson(this);

//   CourseDetailVedio.empty();
// }
