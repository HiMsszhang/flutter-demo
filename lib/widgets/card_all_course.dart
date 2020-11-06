import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class CardAllCourse extends StatefulWidget {
  CardAllCourse({
    Key key,
  }) : super(key: key);

  _CardAllCourseState createState() => _CardAllCourseState();
}

class _CardAllCourseState extends State<CardAllCourse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 690.w,
      margin: EdgeInsets.only(bottom: 14.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.all(30.w),
        onPressed: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    Text('【行书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                Offstage(
                  offstage: false,
                  child: Image.asset('assets/images/course/icon_group_hot.png', width: 36.w, height: 39.w),
                )
              ],
            ),
            SizedBox(height: 15.w),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.w),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Text(
                    '20课时',
                    style: Styles.normalFont(fontSize: 26.sp, color: Colors.white, height: 1.2),
                  ),
                ),
                SizedBox(width: 21.w),
                Image.asset('assets/images/common/icon_learn.png', width: 26.w, height: 20.w),
                SizedBox(width: 10.w),
                Text('321W人', style: Styles.normalFont(fontSize: 24.sp, color: Styles.colorBlue)),
                Expanded(
                  child: Text(
                    '￥1212.00',
                    style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorRed, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xFFF5F5F5),
              margin: EdgeInsets.symmetric(vertical: 20.w),
            ),
            Row(
              children: [
                Image.asset('assets/images/course/icon_starttime.png', width: 23.w, height: 23.w),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text('开课时间：周一、二、三、四、五、天 日更1课时', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
