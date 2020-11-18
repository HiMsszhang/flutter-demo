import 'package:json_annotation/json_annotation.dart';

part 'MineHeadMasterModel.g.dart';

@JsonSerializable()
class MineHeadMasterModel {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0)
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<MineHeadMasterListModel> data;

  MineHeadMasterModel();

  factory MineHeadMasterModel.fromJson(Map<String, dynamic> json) => _$MineHeadMasterModelFromJson(json);

  Map<String, dynamic> toJson() => _$MineHeadMasterModelToJson(this);

  // 命名构造函数
  MineHeadMasterModel.empty();
}

@JsonSerializable()
class MineHeadMasterListModel {
  @JsonKey(name: 'class_teacher_id', defaultValue: 0)
  int classTeacherId;
  @JsonKey(name: 'class_teacher_name', defaultValue: '')
  String classTeacherName;
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;
  @JsonKey(name: 'avatar', defaultValue: '')
  String avatar;
  @JsonKey(defaultValue: '')
  String wechat;
  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;
  MineHeadMasterListModel();

  factory MineHeadMasterListModel.fromJson(Map<String, dynamic> json) => _$MineHeadMasterListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MineHeadMasterListModelToJson(this);

  // 命名构造函数
  MineHeadMasterListModel.empty();
}
