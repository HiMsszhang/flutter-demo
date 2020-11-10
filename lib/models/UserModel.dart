import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  /// 学员编号
  int id;

  /// 学员姓名
  @JsonKey(defaultValue: '')
  String name;

  /// 学员手机号
  @JsonKey(defaultValue: '')
  String mobile;

  /// 学员图像
  @JsonKey(defaultValue: '')
  String avatar;

  /// 学员性别
  int gender;

  /// 学员年龄
  int age;

  /// 学员墨币数量
  @JsonKey(name: 'mo_money', defaultValue: 0)
  int moMoney;

  /// 星星数量
  @JsonKey(name: 'stars_num', defaultValue: 0)
  int starsNum;

  /// 学员token
  @JsonKey(defaultValue: '')
  String token;

  UserModel();

  //反序列化
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel.empty();
}
