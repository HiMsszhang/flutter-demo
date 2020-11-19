import 'package:json_annotation/json_annotation.dart';

part 'InviteModel.g.dart';

@JsonSerializable()
class InviteInfoModel {
  /// 学员名称
  @JsonKey(defaultValue: '')
  String name;

  /// 邀请注册赠送墨币数量
  @JsonKey(name: 'mo_money', defaultValue: '')
  String moMoney;

  InviteInfoModel();

  //反序列化
  factory InviteInfoModel.fromJson(Map<String, dynamic> json) => _$InviteInfoModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$InviteInfoModelToJson(this);

  InviteInfoModel.empty();
}

@JsonSerializable()
class InvitePeopleModel {
  /// 注册时间
  @JsonKey(name: 'create_time', defaultValue: '')
  String createTime;

  /// 学员名称
  @JsonKey(defaultValue: '')
  String name;

  /// 学员手机号
  @JsonKey(defaultValue: '')
  String mobile;

  /// 学员图像
  @JsonKey(defaultValue: '')
  String avatar;

  InvitePeopleModel();

  //反序列化
  factory InvitePeopleModel.fromJson(Map<String, dynamic> json) => _$InvitePeopleModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$InvitePeopleModelToJson(this);

  InvitePeopleModel.empty();
}

@JsonSerializable()
class InvitePeopleListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<InvitePeopleModel> data;

  InvitePeopleListResp();

  factory InvitePeopleListResp.fromJson(Map<String, dynamic> json) => _$InvitePeopleListRespFromJson(json);

  Map<String, dynamic> toJson() => _$InvitePeopleListRespToJson(this);

  // 命名构造函数
  InvitePeopleListResp.empty();
}

@JsonSerializable()
class InviteRewardModel extends InvitePeopleModel {
  /// 记录标题
  @JsonKey(defaultValue: '')
  String title;

  /// 墨币数量
  @JsonKey(name: 'mo_money', defaultValue: 0)
  num moMoney;

  InviteRewardModel();

  //反序列化
  factory InviteRewardModel.fromJson(Map<String, dynamic> json) => _$InviteRewardModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$InviteRewardModelToJson(this);

  InviteRewardModel.empty();
}

@JsonSerializable()
class InviteRewardListResp {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0, name: 'per_page')
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<InviteRewardModel> data;

  InviteRewardListResp();

  factory InviteRewardListResp.fromJson(Map<String, dynamic> json) => _$InviteRewardListRespFromJson(json);

  Map<String, dynamic> toJson() => _$InviteRewardListRespToJson(this);

  // 命名构造函数
  InviteRewardListResp.empty();
}

@JsonSerializable()
class MyInviteModel {
  /// 墨币总数
  @JsonKey(name: 'total_mo_money', defaultValue: 0)
  num totalMoMoney;

  /// 邀请总人数
  @JsonKey(name: 'total_invite_num', defaultValue: 0)
  num totalInviteNum;

  /// 邀请图片
  @JsonKey(name: 'invite_img', defaultValue: '')
  String inviteImg;

  List<InvitePeopleModel> invite;

  MyInviteModel();

  //反序列化
  factory MyInviteModel.fromJson(Map<String, dynamic> json) => _$MyInviteModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$MyInviteModelToJson(this);

  MyInviteModel.empty();
}
