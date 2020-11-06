import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';

class CardNewCourse extends StatefulWidget {
  final double width;
  final double height;
  CardNewCourse({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  _CardNewCourseState createState() => _CardNewCourseState();
}

class _CardNewCourseState extends State<CardNewCourse> {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.w).copyWith(bottom: 30.w),
        decoration: Styles.normalDecoration.copyWith(
          borderRadius: BorderRadius.circular(16.w),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.w),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF5F5F5))),
                  ),
                  child: Row(
                    children: [
                      Text('课程难度', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color666666)),
                      Expanded(
                        child: MiniRatingStar(rating: 3),
                      ),
                      Text('日更3课时', style: Styles.normalFont(fontSize: 22.sp, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 24.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10.w),
                    Text('【楷书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 19.w),
                Text('开课时间：每周一、二、三、四、五、六、日 ', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, fontWeight: FontWeight.bold)),
                SizedBox(height: 19.w),
                Row(
                  children: [
                    CommonAvatar(size: 60.w),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('VICKY老师', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                        SizedBox(height: 4.w),
                        Text('全网最受学生欢迎的楷书老师。', style: Styles.normalFont(fontSize: 22.sp, color: Color(0xFFBBBBBB))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('￥899.00', style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorRed, fontWeight: FontWeight.bold)),
                    SizedBox(width: 23.w),
                    Text('(20课时)', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                  ],
                ),
                Container(
                  width: 162.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48.w),
                    color: Theme.of(context).accentColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '马上报名',
                    style: Styles.normalFont(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
