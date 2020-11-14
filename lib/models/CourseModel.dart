import 'package:json_annotation/json_annotation.dart';

part 'CourseModel.g.dart';

@JsonSerializable()
class CourseModel {
  /// 课程编号
  int id;

  /// 课程标题
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;

  /// 总课时
  @JsonKey(name: 'total_hours', defaultValue: 0)
  num totalHours;

  /// 开课时间
  @JsonKey(name: 'learning_time', defaultValue: '')
  String learningTime;

  /// 日更新课时数
  @JsonKey(name: 'daily_update', defaultValue: 0)
  num dailyUpdate;

  /// 课程难度(1-10)
  @JsonKey(name: 'course_difficulty', defaultValue: 0)
  num courseDifficulty;

  /// 课程难度描述
  @JsonKey(name: 'course_difficulty_desc', defaultValue: '')
  String courseDifficultyDesc;

  /// 课程价格
  @JsonKey(name: 'course_price', defaultValue: '')
  String coursePrice;

  /// 课程分类标题
  @JsonKey(name: 'course_cate_title', defaultValue: '')
  String courseCateTitle;

  /// 老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  /// 老师图像
  @JsonKey(defaultValue: '')
  String avatar;

  /// 平台对老师的评价
  @JsonKey(defaultValue: '')
  String evaluate;

  /// 字体标题
  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;

  /// 学习人数
  @JsonKey(name: 'learn_num', defaultValue: 0)
  num learnNum;

  CourseModel();

  //反序列化
  factory CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  CourseModel.empty();
}

@JsonSerializable()
class CourseModelListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<CourseModel> data;

  CourseModelListResp();

  factory CourseModelListResp.fromJson(Map<String, dynamic> json) => _$CourseModelListRespFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelListRespToJson(this);

  // 命名构造函数
  CourseModelListResp.empty();
}

@JsonSerializable()
class CourseCatModel {
  /// 课程分类编号
  int id;

  /// 课程分类标题
  @JsonKey(name: 'course_cate_title', defaultValue: '')
  String courseCateTitle;

  CourseCatModel();

  //反序列化
  factory CourseCatModel.fromJson(Map<String, dynamic> json) => _$CourseCatModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseCatModelToJson(this);

  CourseCatModel.empty();
}
