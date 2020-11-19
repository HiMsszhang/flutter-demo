import 'package:json_annotation/json_annotation.dart';
import 'package:molan_edu/models/CourseModel.dart';

part 'TeacherModel.g.dart';

@JsonSerializable()
class TeacherInfoModel {
  /// 是否收藏 1是 2否
  @JsonKey(name: 'is_collection', defaultValue: 0)
  num isCollection;

  /// 课程总数
  @JsonKey(name: 'total_course_num', defaultValue: 0)
  num totalCourseNum;

  ///老师信息
  TeacherModel teacher;

  ///课程
  List<TeacherCourseModel> course;

  TeacherInfoModel();

  //反序列化
  factory TeacherInfoModel.fromJson(Map<String, dynamic> json) => _$TeacherInfoModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherInfoModelToJson(this);

  TeacherInfoModel.empty();
}

@JsonSerializable()
class TeacherModel {
  ///老师编号
  int id;

  /// 老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  /// 老师图像
  @JsonKey(defaultValue: '')
  String avatar;

  /// 老师性别
  @JsonKey(defaultValue: 0)
  num gender;

  /// 喜爱度
  @JsonKey(defaultValue: 0)
  num likeability;

  /// 老师介绍
  @JsonKey(defaultValue: '')
  String introduce;

  /// 老师标签
  @JsonKey(name: 'teacher_label', defaultValue: [])
  List<String> teacherLabel;

  TeacherModel();

  //反序列化
  factory TeacherModel.fromJson(Map<String, dynamic> json) => _$TeacherModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  TeacherModel.empty();
}

@JsonSerializable()
class TeacherCourseModel extends CourseModel {
  ///是否参与拼团(is_spell_group):
  ///1-------是
  ///2-------否
  @JsonKey(name: 'is_spell_group', defaultValue: 0)
  int isSpellGroup;

  TeacherCourseModel();

  //反序列化
  factory TeacherCourseModel.fromJson(Map<String, dynamic> json) => _$TeacherCourseModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherCourseModelToJson(this);

  TeacherCourseModel.empty();
}

@JsonSerializable()
class TeacherCourseListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<TeacherCourseModel> data;

  TeacherCourseListResp();

  factory TeacherCourseListResp.fromJson(Map<String, dynamic> json) => _$TeacherCourseListRespFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherCourseListRespToJson(this);

  // 命名构造函数
  TeacherCourseListResp.empty();
}

@JsonSerializable()
class TeacherShareModel {
  ///老师分享编号
  int id;

  ///老师分享标题
  @JsonKey(name: 'share_title', defaultValue: '')
  String shareTitle;

  ///分享类型
  @JsonKey(defaultValue: 0)
  num type;

  ///分享图片
  @JsonKey(defaultValue: '')
  String image;

  ///分享视频
  @JsonKey(defaultValue: '')
  String video;

  ///浏览数量
  @JsonKey(name: 'visite_num', defaultValue: 0)
  num visiteNum;

  ///点赞数量
  @JsonKey(name: 'praise_num', defaultValue: 0)
  num praiseNum;

  ///创建时间
  @JsonKey(name: 'create_time', defaultValue: '')
  String createTime;

  ///老师名称
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;

  ///老师图像
  @JsonKey(defaultValue: '')
  String avatar;

  ///是否点赞
  @JsonKey(name: 'is_praise', defaultValue: 0)
  num isPraise;

  TeacherShareModel();

  //反序列化
  factory TeacherShareModel.fromJson(Map<String, dynamic> json) => _$TeacherShareModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherShareModelToJson(this);

  TeacherShareModel.empty();
}

@JsonSerializable()
class TeacherShareListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<TeacherShareModel> data;

  TeacherShareListResp();

  factory TeacherShareListResp.fromJson(Map<String, dynamic> json) => _$TeacherShareListRespFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherShareListRespToJson(this);

  // 命名构造函数
  TeacherShareListResp.empty();
}
