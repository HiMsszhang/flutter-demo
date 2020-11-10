// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..id = json['id'] as int
    ..name = json['name'] as String ?? ''
    ..mobile = json['mobile'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..gender = json['gender'] as int
    ..age = json['age'] as int
    ..moMoney = json['mo_money'] as int ?? 0
    ..starsNum = json['stars_num'] as int ?? 0
    ..token = json['token'] as String ?? '';
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'age': instance.age,
      'mo_money': instance.moMoney,
      'stars_num': instance.starsNum,
      'token': instance.token,
    };
