import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/pages/course/course_detail.dart';

class CardGroup extends StatefulWidget {
  final double width;
  final double height;
  CardGroup({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  _CardGroupState createState() => _CardGroupState();
}

class _CardGroupState extends State<CardGroup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, CourseDetailPage(isGroup: true));
      },
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        padding: EdgeInsets.fromLTRB(26.w, 26.w, 20.w, 20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16.w),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(163, 163, 163, 0.2),
              blurRadius: 30.w,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 175.w,
                    height: 222.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    child: Stack(
                      children: [
                        Image.asset('assets/images/demo.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 43.w,
                            color: Color.fromRGBO(162, 162, 162, .6),
                            alignment: Alignment.center,
                            child: Text('30课时', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 17.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 30.sp, color: Styles.colorText, fontWeight: FontWeight.bold)),
                            SizedBox(width: 14.w),
                            Text('【楷书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                          ],
                        ),
                        SizedBox(height: 20.w),
                        Container(
                          width: 450.w,
                          height: 80.w,
                          child: Wrap(
                            spacing: 14.w, //主轴上子控件的间距
                            runSpacing: 16.w, //交叉轴上子控件之间的间距
                            children: List.generate(
                              5,
                              (index) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.w),
                                decoration: BoxDecoration(color: Color(0xFFEDEDED), borderRadius: BorderRadius.circular(31.w)),
                                child: Text('3年教龄', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color666666, height: 1.2)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '早鸟拼团价：',
                                  style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666),
                                ),
                                SizedBox(height: 14.w),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '￥1899.00',
                                      style: Styles.normalFont(fontSize: 30.sp, color: Styles.colorRed, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      '￥2199.00',
                                      style: Styles.normalFont(fontSize: 22.sp, color: Color(0xFFB2B2B2), decoration: TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: 145.w,
                              height: 51.w,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 4.w),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/common/btn_bg.png'),
                                  ),
                                  borderRadius: BorderRadius.circular(51.w),
                                  boxShadow: [
                                    BoxShadow(color: Color.fromRGBO(178, 132, 100, 0.33), offset: Offset(2.w, 3.w), blurRadius: 20.w, spreadRadius: 1.w),
                                  ]),
                              child: Text(
                                '立即参团',
                                style: Styles.specialFont(fontSize: 28.sp, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 650.w,
              height: 1,
              color: Color(0xFFF5F5F5),
              margin: EdgeInsets.only(bottom: 20.w),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '开课时间：2020-01-02',
                    style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 2.w,
                  height: 10.w,
                  color: Styles.color666666,
                ),
                Expanded(
                    child: Text(
                  '周一至周五   日更3课时',
                  style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
