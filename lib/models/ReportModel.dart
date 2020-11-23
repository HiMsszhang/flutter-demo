import 'package:json_annotation/json_annotation.dart';
import 'package:molan_edu/models/UserModel.dart';

part 'ReportModel.g.dart';

///我的报告课程列表
@JsonSerializable()
class ReportCourseModel {
  ///课程编号
  @JsonKey(name: "course_id", defaultValue: 0)
  num courseId;

  ///课程标题
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;

  ReportCourseModel();
  //反序列化
  factory ReportCourseModel.fromJson(Map<String, dynamic> json) => _$ReportCourseModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$ReportCourseModelToJson(this);

  ReportCourseModel.empty();
}

@JsonSerializable()
class ReportCourseListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<ReportCourseModel> data;

  ReportCourseListResp();

  factory ReportCourseListResp.fromJson(Map<String, dynamic> json) => _$ReportCourseListRespFromJson(json);

  Map<String, dynamic> toJson() => _$ReportCourseListRespToJson(this);

  ReportCourseListResp.empty();
}

///我的报告列表
@JsonSerializable()
class MyReportModel {
  ///完整度
  @JsonKey(defaultValue: 0)
  num integrity;

  ///工整度
  @JsonKey(defaultValue: 0)
  num neatness;

  ///美观度
  @JsonKey(defaultValue: 0)
  num beauty;

  ///作业图片
  @JsonKey(defaultValue: [])
  List<String> image;

  ///报告日期
  @JsonKey(name: 'create_time', defaultValue: '')
  String createTime;

  ///学员姓名
  @JsonKey(defaultValue: '')
  String name;

  ///学员图像
  @JsonKey(defaultValue: '')
  String avatar;

  ///老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  ///课程分类标题
  @JsonKey(name: 'course_catalogue_title', defaultValue: '')
  String courseCatalogueTitle;

  ///星期
  @JsonKey(defaultValue: '')
  String week;

  ///老师评价
  @JsonKey(defaultValue: '')
  String evaluate;

  MyReportModel();
  //反序列化
  factory MyReportModel.fromJson(Map<String, dynamic> json) => _$MyReportModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$MyReportModelToJson(this);

  MyReportModel.empty();
}

@JsonSerializable()
class MyReportListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<MyReportModel> data;

  MyReportListResp();

  factory MyReportListResp.fromJson(Map<String, dynamic> json) => _$MyReportListRespFromJson(json);

  Map<String, dynamic> toJson() => _$MyReportListRespToJson(this);

  MyReportListResp.empty();
}

///我的报告分析
@JsonSerializable()
class MyReportDetailModel {
  ///用户
  UserModel user;

  ///累计学习时长
  @JsonKey(name: "total_duration", defaultValue: 0)
  num totalDuration;

  ///掌握总字数
  @JsonKey(name: 'total_word_num', defaultValue: 0)
  num totalWordNum;

  ///已学习课时数
  @JsonKey(name: 'total_hours', defaultValue: 0)
  num totalHours;

  ///完成作业次数
  @JsonKey(name: 'total_complete', defaultValue: 0)
  num totalComplete;

  ///星星总数
  @JsonKey(name: 'stars_num', defaultValue: 0)
  num starsNum;

  ///优秀次数
  @JsonKey(name: 'excellent_num', defaultValue: 0)
  num excellentNum;

  ///课程目录列表
  @JsonKey(name: 'course_catalogue_list', defaultValue: [])
  List<String> courseCatalogueList;

  ///学生评价列表
  @JsonKey(name: 'eveluate_list', defaultValue: [])
  List<num> eveluateList;

  MyReportDetailModel();
  //反序列化
  factory MyReportDetailModel.fromJson(Map<String, dynamic> json) => _$MyReportDetailModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$MyReportDetailModelToJson(this);

  MyReportDetailModel.empty();
}
