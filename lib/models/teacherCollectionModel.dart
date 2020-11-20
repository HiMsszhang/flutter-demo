import 'package:json_annotation/json_annotation.dart';
import 'package:molan_edu/models/TeacherModel.dart';
part 'teacherCollectionModel.g.dart';

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
  List<TeacherModel> data;

  TeacherCollectionModel();

  //反序列化
  factory TeacherCollectionModel.fromJson(Map<String, dynamic> json) => _$TeacherCollectionModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherCollectionModelToJson(this);
}
