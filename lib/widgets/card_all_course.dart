import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/TeacherModel.dart';
import 'package:molan_edu/pages/course/course_detail.dart';
import 'package:molan_edu/utils/imports.dart';

class CardAllCourse extends StatefulWidget {
  final TeacherCourseModel data;
  CardAllCourse({
    Key key,
    this.data,
  }) : super(key: key);

  _CardAllCourseState createState() => _CardAllCourseState();
}

class _CardAllCourseState extends State<CardAllCourse> with UtilsMixin {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Container(
      width: 690.w,
      margin: EdgeInsets.only(bottom: 14.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.all(30.w),
        onPressed: () {
          NavigatorUtils.push(context, CourseDetailPage(courseId: data?.id, isGroup: data?.isSpellGroup == 1));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(data?.courseTitle, style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    Text('【${data?.typefaceTitle}.${data?.courseCateTitle}】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                Offstage(
                  offstage: data?.isSpellGroup == 2,
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
                    '${data?.totalHours}课时',
                    style: Styles.normalFont(fontSize: 26.sp, color: Colors.white, height: 1.2),
                  ),
                ),
                SizedBox(width: 21.w),
                Image.asset('assets/images/common/icon_learn.png', width: 26.w, height: 20.w),
                SizedBox(width: 10.w),
                Text('${formatNum(data?.learnNum)}人', style: Styles.normalFont(fontSize: 24.sp, color: Styles.colorBlue)),
                Expanded(
                  child: Text(
                    '￥${data?.coursePrice}',
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
                  child: Text('开课时间：${data?.learningTime} 日更${data?.dailyUpdate}课时', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
