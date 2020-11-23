import 'package:json_annotation/json_annotation.dart';

part 'IntroduceModel.g.dart';

@JsonSerializable()
class IntroduceModel {
  int id;

  @JsonKey(defaultValue: '')
  String title;

  @JsonKey(defaultValue: '')
  String image;

  @JsonKey(name: 'video_url', defaultValue: '')
  String videoUrl;

  ///观看人数
  @JsonKey(name: 'visite_num', defaultValue: 0)
  num visiteNum;

  IntroduceModel();

  //反序列化
  factory IntroduceModel.fromJson(Map<String, dynamic> json) => _$IntroduceModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$IntroduceModelToJson(this);

  IntroduceModel.empty();
}

@JsonSerializable()
class IntroduceListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<IntroduceModel> data;

  IntroduceListResp();

  factory IntroduceListResp.fromJson(Map<String, dynamic> json) => _$IntroduceListRespFromJson(json);

  Map<String, dynamic> toJson() => _$IntroduceListRespToJson(this);

  // 命名构造函数
  IntroduceListResp.empty();
}
