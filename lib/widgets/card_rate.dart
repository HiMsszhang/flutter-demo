import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class CardRate extends StatefulWidget {
  CardRate({
    Key key,
  }) : super(key: key);

  _CardRateState createState() => _CardRateState();
}

class _CardRateState extends State<CardRate> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 22.w),
      onPressed: () {},
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAvatar(size: 70.w),
            SizedBox(width: 17.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('公爵', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                          SizedBox(width: 26.w),
                          Text('10-12', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color666666, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Icon(
                            MyIcons.Iconxiaolian,
                            size: 27.w,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 9.w),
                          Text('超棒！', style: Styles.normalFont(fontSize: 22.sp, color: Theme.of(context).accentColor, height: 1.5)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15.w),
                  Text('来源：第一节', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                  SizedBox(height: 22.w),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.w),
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.w),
                              color: Color(0xFFF5F5F5),
                            ),
                            child: Text('生动活泼', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999, height: 1.2)),
                          ),
                        ),
                        TextSpan(text: '好喜欢这个老师，讲课生动有趣一听就明白，因为老师讲的好我已经喜欢上书法了', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container(width: 636.w, height: _listLength < index ? 0.5 : 0, color: Color(0xFFF6F6F7)),
          ],
        ),
      ),
    );
  }
}
