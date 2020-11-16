import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';

import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/pages/course/course_detail.dart';

class CardNewCourse extends StatefulWidget {
  final double width;
  final double height;
  final CourseModel data;
  CardNewCourse({
    Key key,
    this.width,
    this.height,
    this.data,
  }) : super(key: key);

  _CardNewCourseState createState() => _CardNewCourseState();
}

class _CardNewCourseState extends State<CardNewCourse> {
  @override
  Widget build(BuildContext context) {
    var item = widget.data;
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, CourseDetailPage(courseId: item.id));
      },
      child: UnconstrainedBox(
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
                          child: MiniRatingStar(rating: item.courseDifficulty.toDouble() ?? 0),
                        ),
                        Text('日更${item.dailyUpdate}课时', style: Styles.normalFont(fontSize: 22.sp, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.w),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(item.courseTitle ?? '', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10.w),
                      Text('【${item.typefaceTitle}.${item.courseCateTitle}】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 19.w),
                  Text('开课时间：${item.learningTime}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, fontWeight: FontWeight.bold)),
                  SizedBox(height: 19.w),
                  Row(
                    children: [
                      CommonAvatar(size: 60.w, showSex: false, avatar: item.avatar),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${item.teacherName}老师', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                          SizedBox(height: 4.w),
                          Text(item.evaluate, style: Styles.normalFont(fontSize: 22.sp, color: Color(0xFFBBBBBB))),
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
                      Text('￥${item.coursePrice}', style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorRed, fontWeight: FontWeight.bold)),
                      SizedBox(width: 23.w),
                      Text('(${item.totalHours}课时)', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                    ],
                  ),
                  Container(
                    width: 162.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48.w),
                      color: Theme.of(context).buttonColor,
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
      ),
    );
  }
}
