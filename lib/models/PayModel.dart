import 'package:json_annotation/json_annotation.dart';

part 'PayModel.g.dart';

@JsonSerializable()
class WechatPayModel {
  String appid;
  String partnerid;
  String prepayid;
  String timestamp;
  String noncestr;
  String package;
  String sign;
  @JsonKey(name: 'course_order_id')
  num courseOrderId;

  WechatPayModel();

  //反序列化
  factory WechatPayModel.fromJson(Map<String, dynamic> json) => _$WechatPayModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$WechatPayModelToJson(this);

  WechatPayModel.empty();
}

@JsonSerializable()
class AliPayModel {
  String sign;

  AliPayModel();

  //反序列化
  factory AliPayModel.fromJson(Map<String, dynamic> json) => _$AliPayModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$AliPayModelToJson(this);

  AliPayModel.empty();
}

@JsonSerializable()
class OrderModel {
  OrderCourseModel course;
  List<OrderCourseModeModel> courseModel;

  @JsonKey(name: 'payment_method')
  List<OrderPaymentModel> paymentMethod;

  @JsonKey(name: 'course_order_discount')
  List<OrderDiscountModel> courseOrderDiscount;

  OrderModel();

  //反序列化
  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel.empty();
}

@JsonSerializable()
class OrderCourseModel {
  /// 课程编号
  int id;

  /// 班主任编号
  @JsonKey(name: 'class_teacher_id', defaultValue: 0)
  num classTeacherId;

  /// 课程标题
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;

  /// 普通课程价格
  @JsonKey(name: 'course_price', defaultValue: 0)
  num coursePrice;

  /// VIP课程价格
  @JsonKey(name: 'course_vip_price', defaultValue: 0)
  num courseVipPrice;

  /// 字体标题
  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;

  OrderCourseModel();

  //反序列化
  factory OrderCourseModel.fromJson(Map<String, dynamic> json) => _$OrderCourseModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$OrderCourseModelToJson(this);

  OrderCourseModel.empty();
}

@JsonSerializable()
class OrderCourseModeModel {
  /// 课程学习模式编号
  int id;

  /// 课程学习模式标题
  @JsonKey(name: 'course_model_title', defaultValue: '')
  String courseModelTitle;

  /// 课程学习模式描述
  @JsonKey(defaultValue: '')
  String desc;

  OrderCourseModeModel();

  //反序列化
  factory OrderCourseModeModel.fromJson(Map<String, dynamic> json) => _$OrderCourseModeModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$OrderCourseModeModelToJson(this);

  OrderCourseModeModel.empty();
}

@JsonSerializable()
class OrderPaymentModel {
  /// 支付方式编号
  int id;

  /// 支付方式标题
  @JsonKey(name: 'pay_title', defaultValue: '')
  String payTitle;

  OrderPaymentModel();

  //反序列化
  factory OrderPaymentModel.fromJson(Map<String, dynamic> json) => _$OrderPaymentModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$OrderPaymentModelToJson(this);

  OrderPaymentModel.empty();
}

@JsonSerializable()
class OrderDiscountModel {
  /// 课程订单抵扣规则编号
  int id;

  /// 课程订单抵扣规则标题
  @JsonKey(name: 'rule_title', defaultValue: '')
  String ruleTitle;

  /// 课程价格
  @JsonKey(name: 'course_price', defaultValue: 0)
  num coursePrice;

  /// 抵扣墨币数量
  @JsonKey(defaultValue: 0)
  num discount;

  OrderDiscountModel();

  //反序列化
  factory OrderDiscountModel.fromJson(Map<String, dynamic> json) => _$OrderDiscountModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$OrderDiscountModelToJson(this);

  OrderDiscountModel.empty();
}

@JsonSerializable()
class PaySuccessModel {
  /// 班主任名称
  @JsonKey(name: 'class_teacher_name', defaultValue: '')
  String classTeacherName;

  /// 班主任图像
  @JsonKey(defaultValue: '')
  String avatar;

  /// 班主任微信号
  @JsonKey(defaultValue: '')
  String wechat;

  /// 班主任微信二维码
  @JsonKey(name: 'wechat_code', defaultValue: '')
  String wechatCode;

  PaySuccessModel();

  //反序列化
  factory PaySuccessModel.fromJson(Map<String, dynamic> json) => _$PaySuccessModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$PaySuccessModelToJson(this);

  PaySuccessModel.empty();
}
