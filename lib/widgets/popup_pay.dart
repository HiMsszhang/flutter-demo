import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/apis/pay.dart';
import 'package:molan_edu/models/WechatPayModel.dart';

class PopupPay extends StatefulWidget {
  final bool showTags;
  PopupPay({
    Key key,
    this.showTags = false,
  }) : super(key: key);

  _PopupPayState createState() => _PopupPayState();
}

class _PopupPayState extends State<PopupPay> {
  List<Map> _tabList = [
    {'title': '自学模式'},
    {'title': 'VIP模式'},
  ];
  int _tabIndex = 0;
  List<Map> _radioList = [
    {'title': '支付宝支付', 'name': 'alipay'},
    {'title': '微信支付', 'name': 'wechat'},
  ];
  int _radioIndex = 0;
  bool _useMo = false;

  _onRadioChanged(int index) {
    _radioIndex = index;
    setState(() {});
  }

  _onMoTap() {
    _useMo = !_useMo;
    setState(() {});
  }

  _pay() async {
    DataResult data = await PayAPI.payNow(
      courseId: 2,
      courseModelId: 1,
      paymentMethodId: 2,
      discountMoMoney: 0,
      coursePrice: 0.01,
    );
    WechatPayModel res = data.data;
    payWithWeChat(
      appId: res.appid,
      partnerId: res.partnerid,
      prepayId: res.prepayid,
      packageValue: res.package,
      nonceStr: res.noncestr,
      timeStamp: int.parse(res.timestamp),
      sign: res.sign,
    )
        .then(
      (value) => print('>>>>>>>>>>>>>>$value'),
    )
        .catchError((onError) {
      print('>>>>>>>>>>>>>>1$onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
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
                Text('【行书】勤礼碑一系列', style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 28.w),
                Row(
                  children: List.generate(
                    _tabList.length,
                    (index) => _widgetTabItem(index),
                  ),
                ),
                SizedBox(height: 26.w),
                Text('模拟介绍：自学模式适合自律性自主性较高且有一定基础的孩子，通过观看视频自行完成课后作业', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.5)),
              ],
            ),
          ),
          _widgetWrapper(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('金额', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                Text('金额￥999.00', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
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
          _widgetMo(),
          ...List.generate(_radioList.length, (index) => _widgetRadioItem(index)),
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
                    child: Text('￥799.00', style: Styles.normalFont(fontSize: 36.sp, color: Styles.colorRed, fontWeight: FontWeight.bold)),
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
      ),
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
    var item = _tabList[index];
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
          setState(() {});
        },
        child: Text(
          item['title'],
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
              child: Text('可抵扣墨币：200\n(剩余400)', style: Styles.normalFont(fontSize: 28.sp)),
            ),
            Offstage(
              offstage: !_useMo,
              child: Text('本单已减￥200.00', style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFD71313))),
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
    var item = _radioList[index];
    return Container(
      child: RawMaterialButton(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
        onPressed: () {
          _onRadioChanged(index);
        },
        child: Row(
          children: [
            Image.asset('assets/images/common/type_${item['name']}.png', width: 51.w, height: 51.w),
            SizedBox(width: 18.w),
            Expanded(
              child: Text(item['title'], style: Styles.normalFont(fontSize: 28.sp)),
            ),
            Offstage(
              offstage: _radioIndex != index,
              child: Text('实际支付￥799.00', style: Styles.normalFont(fontSize: 24.sp)),
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
