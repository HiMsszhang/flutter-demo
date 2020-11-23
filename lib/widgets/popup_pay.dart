import 'dart:async';

import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/apis/pay.dart';
import 'package:molan_edu/models/PayModel.dart';
import 'package:fluwx/fluwx.dart';
import 'package:tobias/tobias.dart' as tobias;
import 'package:molan_edu/pages/course/pay_result.dart';

class PopupPay extends StatefulWidget {
  final int id;
  PopupPay({
    Key key,
    this.id,
  }) : super(key: key);

  _PopupPayState createState() => _PopupPayState();
}

class _PopupPayState extends State<PopupPay> with UtilsMixin {
  UserModel _user;
  int _tabIndex = 0;
  int _radioIndex = 0;
  bool _useMo = false;
  int _discount = 0;
  num _price = 0;
  bool _loadFlag = false;

  OrderModel _data;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await context.read<UserState>().getUser();
      await _getData();
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    EasyLoading.dismiss();
    super.dispose();
  }

  _getData() async {
    DataResult res = await PayAPI.order(courseId: widget.id);
    _data = res.data;
    _price = _data?.courseModel[_tabIndex]?.id == 2 ? _data?.course?.courseVipPrice : _data?.course?.coursePrice;
    _loadFlag = true;
    setState(() {});
    _getDiscount();
  }

  _onRadioChanged(int index) {
    _radioIndex = index;
    setState(() {});
  }

  _onMoTap() {
    _useMo = !_useMo;
    setState(() {});
  }

  _pay() async {
    /// 1支付宝 2微信
    var paymentId = _data?.paymentMethod[_radioIndex]?.id;
    DataResult data = await PayAPI.payNow(
      courseId: _data.course.id,
      courseModelId: _data?.courseModel[_tabIndex]?.id,
      paymentMethodId: paymentId,
      discountMoMoney: _discount,
      coursePrice: _price,
    );
    if (paymentId == 1) {
      try {
        AliPayModel res = data.data;
        print("The pay info is : " + res.sign);
        var payResult = await tobias.aliPay(res.sign);
        print("--->$payResult");
        if (payResult['resultStatus'] == 9000) {
          _paySuccess();
        } else {
          _payFail();
        }
      } catch (e) {
        print("error--->$e");
        _payFail();
      }
    } else if (paymentId == 2) {
      try {
        WechatPayModel res = data.data;
        var payResult = await payWithWeChat(
          appId: res.appid,
          partnerId: res.partnerid,
          prepayId: res.prepayid,
          packageValue: res.package,
          nonceStr: res.noncestr,
          timeStamp: int.parse(res.timestamp),
          sign: res.sign,
        );
        print("--->$payResult");
        EasyLoading.show(status: '支付中', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
        _timer = Timer.periodic(new Duration(seconds: 1), (timer) async {
          debugPrint(timer.tick.toString());
          await _getWxResult(res.courseOrderId);
        });
        // _paySuccess();
      } catch (e) {
        print("error--->$e");
        _payFail();
      }
    }
  }

  _getWxResult(int orderId) async {
    DataResult res = await PayAPI.wxResult(courseOrderId: orderId);

    ///课程订单状态(order_status):
    ///1-------待支付
    ///2-------取消订单
    ///3-------订单完成
    var status = res.data['order_status'];
    switch (status) {
      case 1:
        return;
        break;
      case 2:
        _payFail();
        break;
      case 3:
        _paySuccess();
        break;
      default:
        return;
    }
  }

  _paySuccess() {
    showToast('支付成功');
    EasyLoading.dismiss();
    NavigatorUtils.popAndPush(context, PayResultPage(id: _data?.course?.classTeacherId));
  }

  _payFail() {
    showToast('支付失败');
    EasyLoading.dismiss();
    NavigatorUtils.pop(context);
  }

  _getDiscount() {
    List.generate(_data?.courseOrderDiscount?.length, (index) {
      var preItem = index == 0 ? 0 : _data?.courseOrderDiscount[index - 1]?.coursePrice;
      var item = _data?.courseOrderDiscount[index]?.coursePrice;
      if (preItem <= _price && item > _price) {
        _discount = _data?.courseOrderDiscount[index]?.discount;
      }
    });
    setState(() {});
  }

  _finalMoney() {
    var price = _price;

    if (_useMo) {
      price = _price - _discount;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    _user = context.watch<UserState>().userInfo;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
        color: _loadFlag ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: _loadFlag
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _widgetWrapper(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('课程种类', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                      ),
                      Image.asset('assets/images/course/icon_question.png', width: 32.w, height: 27.w),
                      SizedBox(width: 10.w),
                      Text(
                        '我家宝贝适合哪种呢？',
                        style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFF8898BA), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _widgetWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('【${_data?.course?.typefaceTitle}】${_data?.course?.courseTitle}', style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 28.w),
                      Row(
                        children: List.generate(
                          _data?.courseModel?.length ?? 0,
                          (index) => _widgetTabItem(index),
                        ),
                      ),
                      SizedBox(height: 26.w),
                      Text(_data?.courseModel[_tabIndex]?.desc ?? '', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.5)),
                    ],
                  ),
                ),
                _widgetWrapper(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('金额', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                      Text('金额￥$_price', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
                    ],
                  ),
                ),
                _widgetWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '支付方式',
                        style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _discount > 0 && _user.moMoney > _discount ? _widgetMo() : Container(),
                ...List.generate(_data?.paymentMethod?.length ?? 0, (index) => _widgetRadioItem(index)),
                SizedBox(height: 20.w),
                SafeArea(
                  top: false,
                  bottom: true,
                  child: Container(
                    decoration: Styles.normalDecoration,
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('￥${_finalMoney()}', style: Styles.normalFont(fontSize: 36.sp, color: Styles.colorRed, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75.w),
                            color: Theme.of(context).accentColor,
                          ),
                          child: RawMaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.w),
                            onPressed: () {
                              _pay();
                            },
                            child: Text('立即支付', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  Widget _widgetWrapper({Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFF5F5F5))),
      ),
      child: child,
    );
  }

  Widget _widgetTabItem(int index) {
    var item = _data?.courseModel[index];
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(54.w),
        color: _tabIndex == index ? Color(0xFFFFC4A3) : Colors.white,
        border: Border.all(width: 1, color: Color(0xFFFFC4A3)),
      ),
      height: 54.w,
      margin: EdgeInsets.only(right: 35.w),
      alignment: Alignment.center,
      child: RawMaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        onPressed: () {
          _tabIndex = index;
          _price = _data?.courseModel[_tabIndex]?.id == 2 ? _data?.course?.courseVipPrice : _data?.course?.coursePrice;
          setState(() {});
          _getDiscount();
        },
        child: Text(
          item?.courseModelTitle ?? '',
          style: Styles.normalFont(fontSize: 26.sp, color: _tabIndex == index ? Colors.white : Color(0xFFFFC4A3), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _widgetMo() {
    return Container(
      child: RawMaterialButton(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
        onPressed: () {
          _onMoTap();
        },
        child: Row(
          children: [
            Image.asset('assets/images/common/type_mo.png', width: 51.w, height: 51.w),
            SizedBox(width: 18.w),
            Expanded(
              child: Text('可抵扣墨币：$_discount\n(剩余${_user?.moMoney})', style: Styles.normalFont(fontSize: 28.sp)),
            ),
            Offstage(
              offstage: !_useMo,
              child: Text('本单已减￥$_discount', style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFD71313))),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(44.w),
                border: Border.all(width: 1, color: _useMo ? Theme.of(context).accentColor : Styles.color999999),
                color: _useMo ? Theme.of(context).accentColor : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.check, size: 30.w, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetRadioItem(int index) {
    var item = _data?.paymentMethod[index];
    return Container(
      child: RawMaterialButton(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
        onPressed: () {
          _onRadioChanged(index);
        },
        child: Row(
          children: [
            Image.asset('assets/images/common/type_${item.id == 1 ? "alipay" : "wechat"}.png', width: 51.w, height: 51.w),
            SizedBox(width: 18.w),
            Expanded(
              child: Text(item.payTitle, style: Styles.normalFont(fontSize: 28.sp)),
            ),
            Offstage(
              offstage: _radioIndex != index,
              child: Text('实际支付￥${_finalMoney()}', style: Styles.normalFont(fontSize: 24.sp)),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(44.w),
                border: Border.all(width: 1, color: _radioIndex == index ? Theme.of(context).accentColor : Styles.color999999),
                color: _radioIndex == index ? Theme.of(context).accentColor : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.check, size: 30.w, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
