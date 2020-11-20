// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PayModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatPayModel _$WechatPayModelFromJson(Map<String, dynamic> json) {
  return WechatPayModel()
    ..appid = json['appid'] as String
    ..partnerid = json['partnerid'] as String
    ..prepayid = json['prepayid'] as String
    ..timestamp = json['timestamp'] as String
    ..noncestr = json['noncestr'] as String
    ..package = json['package'] as String
    ..sign = json['sign'] as String
    ..courseOrderId = json['course_order_id'] as num;
}

Map<String, dynamic> _$WechatPayModelToJson(WechatPayModel instance) =>
    <String, dynamic>{
      'appid': instance.appid,
      'partnerid': instance.partnerid,
      'prepayid': instance.prepayid,
      'timestamp': instance.timestamp,
      'noncestr': instance.noncestr,
      'package': instance.package,
      'sign': instance.sign,
      'course_order_id': instance.courseOrderId,
    };

AliPayModel _$AliPayModelFromJson(Map<String, dynamic> json) {
  return AliPayModel()..sign = json['sign'] as String;
}

Map<String, dynamic> _$AliPayModelToJson(AliPayModel instance) =>
    <String, dynamic>{
      'sign': instance.sign,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel()
    ..course = json['course'] == null
        ? null
        : OrderCourseModel.fromJson(json['course'] as Map<String, dynamic>)
    ..courseModel = (json['courseModel'] as List)
        ?.map((e) => e == null
            ? null
            : OrderCourseModeModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..paymentMethod = (json['payment_method'] as List)
        ?.map((e) => e == null
            ? null
            : OrderPaymentModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..courseOrderDiscount = (json['course_order_discount'] as List)
        ?.map((e) => e == null
            ? null
            : OrderDiscountModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'course': instance.course,
      'courseModel': instance.courseModel,
      'payment_method': instance.paymentMethod,
      'course_order_discount': instance.courseOrderDiscount,
    };

OrderCourseModel _$OrderCourseModelFromJson(Map<String, dynamic> json) {
  return OrderCourseModel()
    ..id = json['id'] as int
    ..classTeacherId = json['class_teacher_id'] as num ?? 0
    ..courseTitle = json['course_title'] as String ?? ''
    ..coursePrice = json['course_price'] as num ?? 0
    ..courseVipPrice = json['course_vip_price'] as num ?? 0
    ..typefaceTitle = json['typeface_title'] as String ?? '';
}

Map<String, dynamic> _$OrderCourseModelToJson(OrderCourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class_teacher_id': instance.classTeacherId,
      'course_title': instance.courseTitle,
      'course_price': instance.coursePrice,
      'course_vip_price': instance.courseVipPrice,
      'typeface_title': instance.typefaceTitle,
    };

OrderCourseModeModel _$OrderCourseModeModelFromJson(Map<String, dynamic> json) {
  return OrderCourseModeModel()
    ..id = json['id'] as int
    ..courseModelTitle = json['course_model_title'] as String ?? ''
    ..desc = json['desc'] as String ?? '';
}

Map<String, dynamic> _$OrderCourseModeModelToJson(
        OrderCourseModeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_model_title': instance.courseModelTitle,
      'desc': instance.desc,
    };

OrderPaymentModel _$OrderPaymentModelFromJson(Map<String, dynamic> json) {
  return OrderPaymentModel()
    ..id = json['id'] as int
    ..payTitle = json['pay_title'] as String ?? '';
}

Map<String, dynamic> _$OrderPaymentModelToJson(OrderPaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pay_title': instance.payTitle,
    };

OrderDiscountModel _$OrderDiscountModelFromJson(Map<String, dynamic> json) {
  return OrderDiscountModel()
    ..id = json['id'] as int
    ..ruleTitle = json['rule_title'] as String ?? ''
    ..coursePrice = json['course_price'] as num ?? 0
    ..discount = json['discount'] as num ?? 0;
}

Map<String, dynamic> _$OrderDiscountModelToJson(OrderDiscountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rule_title': instance.ruleTitle,
      'course_price': instance.coursePrice,
      'discount': instance.discount,
    };

PaySuccessModel _$PaySuccessModelFromJson(Map<String, dynamic> json) {
  return PaySuccessModel()
    ..classTeacherName = json['class_teacher_name'] as String ?? ''
    ..avatar = json['avatar'] as String ?? ''
    ..wechat = json['wechat'] as String ?? ''
    ..wechatCode = json['wechat_code'] as String ?? '';
}

Map<String, dynamic> _$PaySuccessModelToJson(PaySuccessModel instance) =>
    <String, dynamic>{
      'class_teacher_name': instance.classTeacherName,
      'avatar': instance.avatar,
      'wechat': instance.wechat,
      'wechat_code': instance.wechatCode,
    };
