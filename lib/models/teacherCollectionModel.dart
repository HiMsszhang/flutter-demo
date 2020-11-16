import 'package:json_annotation/json_annotation.dart';
part 'teacherCollectionModel.g.dart';

@JsonSerializable()
class TeacherCollectionListModel {
  @JsonKey(name: 'teacher_id', defaultValue: 0)
  num teacherId;
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;
  @JsonKey(defaultValue: '')
  String avatar;
  @JsonKey(defaultValue: '')
  String introduce;
  @JsonKey(defaultValue: 0)
  num likeability;
  TeacherCollectionListModel();

  //反序列化
  factory TeacherCollectionListModel.fromJson(Map<String, dynamic> json) => _$TeacherCollectionListModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherCollectionListModelToJson(this);
}

@JsonSerializable()
class TeacherCollectionModel {
  @JsonKey(name: 'total', defaultValue: 0)
  int total;
  @JsonKey(name: 'per_page', defaultValue: 0)
  int perPage;
  @JsonKey(name: 'current_page', defaultValue: 0)
  int currentPage;
  @JsonKey(name: 'last_page', defaultValue: 0)
  int lastPage;
  @JsonKey(defaultValue: [])
  List<TeacherCollectionListModel> data;

  TeacherCollectionModel();

  //反序列化
  factory TeacherCollectionModel.fromJson(Map<String, dynamic> json) => _$TeacherCollectionModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherCollectionModelToJson(this);
}
