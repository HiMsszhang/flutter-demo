import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class CardChat extends StatefulWidget {
  CardChat({
    Key key,
  }) : super(key: key);

  _CardChatState createState() => _CardChatState();
}

class _CardChatState extends State<CardChat> {
  List<Map> _labelList = [
    {'title': '课程原价'},
    {'title': '实际支付'},
    {'title': '墨币抵扣'},
    {'title': '墨币余额'},
    {'title': '支付方式'},
    {'title': '支付状态'},
    {'title': '支付时间'},
    {'title': '交易单号'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.all(30.w),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset('assets/images/chat/icon_book.png', width: 33.w, height: 33.w, fit: BoxFit.contain),
                SizedBox(width: 10.w),
                Text('【行书.钢笔】勤礼碑一系列-自学模式', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
              ],
            ),
            SizedBox(height: 59.w),
            Text('支付金额', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color666666)),
            SizedBox(height: 23.w),
            Text('￥1799.00', style: Styles.normalFont(fontSize: 54.sp, fontWeight: FontWeight.bold)),
            Container(
              width: 630.w,
              height: 1,
              margin: EdgeInsets.only(top: 59.w, bottom: 15.w),
              color: Color(0xFFF5F5F5),
            ),
            ...List.generate(
              _labelList.length,
              (index) => Container(
                margin: EdgeInsets.only(top: 24.w),
                child: Row(
                  children: [
                    Text(_labelList[index]['title'], style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999)),
                    SizedBox(width: 20.w),
                    Text('￥1999.00', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color666666)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
