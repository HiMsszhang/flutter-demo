import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class CardChat extends StatefulWidget {
  final Map data;
  CardChat({
    Key key,
    this.data,
  }) : super(key: key);

  _CardChatState createState() => _CardChatState();
}

class _CardChatState extends State<CardChat> {
  List<Map> _labelList = [
    {'title': '课程原价', 'name': 'course_price', 'suffix': '￥'},
    {'title': '实际支付', 'name': 'order_price', 'suffix': '￥'},
    {'title': '墨币抵扣', 'name': 'discount_mo_money', 'suffix': '￥'},
    {'title': '墨币余额', 'name': 'mo_money', 'suffix': '￥'},
    {'title': '支付方式', 'name': 'payment_method_id', 'suffix': ''},
    {'title': '支付状态', 'name': 'order_status', 'suffix': ''},
    {'title': '支付时间', 'name': 'pay_time', 'suffix': ''},
    {'title': '交易单号', 'name': 'trade_no', 'suffix': ''},
  ];

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Container(
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: EdgeInsets.all(30.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset('assets/images/chat/icon_book.png', width: 33.w, height: 33.w, fit: BoxFit.contain),
                SizedBox(width: 10.w),
                Text('【${data["typeface_title"]}.${data["course_cate_title"]}】${data["course_title"]}-${data["course_model_title"]}', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
              ],
            ),
            SizedBox(height: 59.w),
            Text('支付金额', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color666666)),
            SizedBox(height: 23.w),
            Text('￥${data["order_price"]}', style: Styles.normalFont(fontSize: 54.sp, fontWeight: FontWeight.bold)),
            Container(
              width: 630.w,
              height: 1,
              margin: EdgeInsets.only(top: 59.w, bottom: 15.w),
              color: Color(0xFFF5F5F5),
            ),
            ...List.generate(
              _labelList.length,
              (index) {
                var item = _labelList[index];
                return Container(
                  margin: EdgeInsets.only(top: 24.w),
                  child: Row(
                    children: [
                      Text(item['title'], style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999)),
                      SizedBox(width: 20.w),
                      Text('${item["suffix"]}${widget.data[item["name"]]}', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color666666)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
