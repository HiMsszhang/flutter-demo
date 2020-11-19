// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InviteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteInfoModel _$InviteInfoModelFromJson(Map<String, dynamic> json) {
  return InviteInfoModel()
    ..name = json['name'] as String ?? ''
    ..moMoney = json['mo_money'] as String ?? '';
}

Map<String, dynamic> _$InviteInfoModelToJson(InviteInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mo_money': instance.moMoney,
    };

InvitePeopleModel _$InvitePeopleModelFromJson(Map<String, dynamic> json) {
  return InvitePeopleModel()
    ..createTime = json['create_time'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..mobile = json['mobile'] as String ?? ''
    ..avatar = json['avatar'] as String ?? '';
}

Map<String, dynamic> _$InvitePeopleModelToJson(InvitePeopleModel instance) =>
    <String, dynamic>{
      'create_time': instance.createTime,
      'name': instance.name,
      'mobile': instance.mobile,
      'avatar': instance.avatar,
    };

InvitePeopleListResp _$InvitePeopleListRespFromJson(Map<String, dynamic> json) {
  return InvitePeopleListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : InvitePeopleModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$InvitePeopleListRespToJson(
        InvitePeopleListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

InviteRewardModel _$InviteRewardModelFromJson(Map<String, dynamic> json) {
  return InviteRewardModel()
    ..createTime = json['create_time'] as String ?? ''
    ..name = json['name'] as String ?? ''
    ..mobile = json['mobile'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..title = json['title'] as String ?? ''
    ..moMoney = json['mo_money'] as num ?? 0;
}

Map<String, dynamic> _$InviteRewardModelToJson(InviteRewardModel instance) =>
    <String, dynamic>{
      'create_time': instance.createTime,
      'name': instance.name,
      'mobile': instance.mobile,
      'avatar': instance.avatar,
      'title': instance.title,
      'mo_money': instance.moMoney,
    };

InviteRewardListResp _$InviteRewardListRespFromJson(Map<String, dynamic> json) {
  return InviteRewardListResp()
    ..total = json['total'] as int ?? 0
    ..perPage = json['per_page'] as int ?? 0
    ..currentPage = json['current_page'] as int ?? 0
    ..lastPage = json['last_page'] as int ?? 0
    ..data = (json['data'] as List)
            ?.map((e) => e == null
                ? null
                : InviteRewardModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [];
}

Map<String, dynamic> _$InviteRewardListRespToJson(
        InviteRewardListResp instance) =>
    <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };

MyInviteModel _$MyInviteModelFromJson(Map<String, dynamic> json) {
  return MyInviteModel()
    ..totalMoMoney = json['total_mo_money'] as num ?? 0
    ..totalInviteNum = json['total_invite_num'] as num ?? 0
    ..inviteImg = json['invite_img'] as String ?? ''
    ..invite = (json['invite'] as List)
        ?.map((e) => e == null
            ? null
            : InvitePeopleModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MyInviteModelToJson(MyInviteModel instance) =>
    <String, dynamic>{
      'total_mo_money': instance.totalMoMoney,
      'total_invite_num': instance.totalInviteNum,
      'invite_img': instance.inviteImg,
      'invite': instance.invite,
    };
