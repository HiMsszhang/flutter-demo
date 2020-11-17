import 'package:json_annotation/json_annotation.dart';

part 'TimeTableModel.g.dart';

@JsonSerializable()
class TimeTableModel {
  /// 课程编号
  @JsonKey(name: 'course_id', defaultValue: 0)
  num courseId;

  /// 课程学习模式
  @JsonKey(name: 'course_model_id', defaultValue: 0)
  num courseModelId;

  /// 课程标题
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;

  /// 课程难度
  @JsonKey(name: 'course_difficulty', defaultValue: 0)
  num courseDifficulty;

  /// 学习时间
  @JsonKey(name: 'learning_time', defaultValue: '')
  String learningTime;

  /// 日更新课时数
  @JsonKey(name: 'daily_update', defaultValue: 0)
  num dailyUpdate;

  /// 课程分类标题
  @JsonKey(name: 'course_cate_title', defaultValue: '')
  String courseCateTitle;

  /// 字体标题
  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;

  /// 老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  /// 老师图像
  @JsonKey(defaultValue: '')
  String avatar;

  /// 已学课时
  @JsonKey(name: 'learned_num', defaultValue: 0)
  num learnedNum;

  /// 剩余课时
  @JsonKey(name: 'surplus_num', defaultValue: 0)
  num surplusNum;

  /// 学习状态
  @JsonKey(name: 'study_status', defaultValue: 0)
  num studyStatus;

  TimeTableModel();

  //反序列化
  factory TimeTableModel.fromJson(Map<String, dynamic> json) => _$TimeTableModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TimeTableModelToJson(this);

  TimeTableModel.empty();
}

@JsonSerializable()
class TimeTableListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<TimeTableModel> data;

  TimeTableListResp();

  factory TimeTableListResp.fromJson(Map<String, dynamic> json) => _$TimeTableListRespFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTableListRespToJson(this);

  // 命名构造函数
  TimeTableListResp.empty();
}

///课程目录列表
@JsonSerializable()
class TimeTableMenuModel {
  /// 课程目录编号
  @JsonKey(defaultValue: 0)
  num id;

  /// 课程目录标题
  @JsonKey(name: 'course_catalogue_title', defaultValue: '')
  String courseCatalogueTitle;

  /// 课时标题
  @JsonKey(name: 'course_arrangement', defaultValue: '')
  String courseArrangement;

  /// 课程图片
  @JsonKey(defaultValue: '')
  String image;

  /// 是否解锁
  @JsonKey(name: 'is_lock', defaultValue: 0)
  num isLock;

  /// 完成状态
  @JsonKey(name: 'completion_status', defaultValue: 0)
  num completionStatus;

  /// 开放时间
  @JsonKey(name: 'opening_time', defaultValue: '')
  String openingTime;

  /// 上次学到状态
  @JsonKey(name: 'last_learning_status', defaultValue: 0)
  num lastLearningStatus;

  TimeTableMenuModel();

  //反序列化
  factory TimeTableMenuModel.fromJson(Map<String, dynamic> json) => _$TimeTableMenuModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TimeTableMenuModelToJson(this);

  TimeTableMenuModel.empty();
}

@JsonSerializable()
class TimeTableMenuListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<TimeTableMenuModel> data;

  TimeTableMenuListResp();

  factory TimeTableMenuListResp.fromJson(Map<String, dynamic> json) => _$TimeTableMenuListRespFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTableMenuListRespToJson(this);

  // 命名构造函数
  TimeTableMenuListResp.empty();
}

///课程目录详情
@JsonSerializable()
class TimeTableMenuDetailModel {
  /// 课程目录编号
  @JsonKey(defaultValue: 0)
  num id;

  /// 课程目录标题
  @JsonKey(name: 'course_catalogue_title', defaultValue: '')
  String courseCatalogueTitle;

  /// 课程编号
  @JsonKey(name: 'course_id', defaultValue: 0)
  num courseId;

  /// 课程图片
  @JsonKey(defaultValue: '')
  String image;

  /// 课时标题
  @JsonKey(name: 'course_arrangement', defaultValue: '')
  String courseArrangement;

  /// 视频地址
  @JsonKey(defaultValue: '')
  String url;

  /// 老师编号
  @JsonKey(name: 'teacher_id', defaultValue: 0)
  num teacherId;

  /// 老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  /// 完成状态
  @JsonKey(name: 'completion_status', defaultValue: 0)
  num completionStatus;

  /// 课程学习模式编号
  @JsonKey(name: 'course_model_id', defaultValue: 0)
  num courseModelId;

  TimeTableMenuDetailModel();

  //反序列化
  factory TimeTableMenuDetailModel.fromJson(Map<String, dynamic> json) => _$TimeTableMenuDetailModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TimeTableMenuDetailModelToJson(this);

  TimeTableMenuDetailModel.empty();
}

///老师评价标签
@JsonSerializable()
class TeacherRateModel {
  /// 老师评价标签编号
  @JsonKey(defaultValue: 0)
  num id;

  /// 老师评价标签标题
  @JsonKey(name: 'label_title', defaultValue: '')
  String labelTitle;

  TeacherRateModel();

  //反序列化
  factory TeacherRateModel.fromJson(Map<String, dynamic> json) => _$TeacherRateModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherRateModelToJson(this);

  TeacherRateModel.empty();
}
