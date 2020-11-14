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
