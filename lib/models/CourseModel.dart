import 'package:json_annotation/json_annotation.dart';

part 'CourseModel.g.dart';

//课程
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

//课程详情
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

  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);

  // CourseDetailModel.empty();
}

//课程目录
@JsonSerializable()
class CourseCataloguelistModle {
  //课程目录编号
  int id;
  //课程目录标题
  @JsonKey(name: "course_catalogue_title", defaultValue: '')
  String courseCatalogueTitle;

  //课程安排标题
  @JsonKey(name: 'course_arrangement', defaultValue: '')
  String courseArrangement;

  //课程视频链接
  @JsonKey(defaultValue: '')
  String url;

  //视频课程时长
  @JsonKey(defaultValue: '')
  num duration;
  CourseCataloguelistModle();
  //反序列化
  factory CourseCataloguelistModle.fromJson(Map<String, dynamic> json) => _$CourseCataloguelistModleFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseCataloguelistModleToJson(this);
}

@JsonSerializable()
class CourseCataloguelistModleListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<CourseCataloguelistModle> data;

  CourseCataloguelistModleListResp();

  factory CourseCataloguelistModleListResp.fromJson(Map<String, dynamic> json) => _$CourseCataloguelistModleListRespFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCataloguelistModleListRespToJson(this);
}

//课程相关推荐
@JsonSerializable()
class CourseRecommendModle {
  int id;

  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;

  @JsonKey(name: 'total_hours', defaultValue: 0)
  int totalHours;

  @JsonKey(name: 'course_introduct', defaultValue: '')
  String courseIntroduct;

  @JsonKey(name: 'course_difficulty', defaultValue: 0)
  int courseDifficulty;

  @JsonKey(name: 'course_difficulty_desc', defaultValue: '')
  String courseDifficultyDesc;

  @JsonKey(name: 'course_price', defaultValue: '')
  String coursePrice;

  @JsonKey(name: 'course_cate_title', defaultValue: '')
  String courseCateTitle;

  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  @JsonKey(defaultValue: '')
  String avatar;

  @JsonKey(defaultValue: '')
  String evaluate;

  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;

  @JsonKey(name: 'learn_num', defaultValue: 0)
  int learnNum;

  CourseRecommendModle();

  //反序列化
  factory CourseRecommendModle.fromJson(Map<String, dynamic> json) => _$CourseRecommendModleFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseRecommendModleToJson(this);
  CourseRecommendModle.enty();
}
