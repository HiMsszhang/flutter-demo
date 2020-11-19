import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/pages/course/course_detail.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';

class CardMineCourse extends StatefulWidget {
  final bool showTags;
  final data;
  final index;
  CardMineCourse({
    Key key,
    this.showTags = false,
    this.data,
    this.index,
  }) : super(key: key);

  _CardMineCourseState createState() => _CardMineCourseState();
}

class _CardMineCourseState extends State<CardMineCourse> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.data[widget.index];
    return Container(
      margin: EdgeInsets.only(bottom: 20.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        onPressed: () {
          NavigatorUtils.push(
            context,
            CourseDetailPage(courseId: item.course.id),
          );
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30.w, 30.w, 0, 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(item.course.courseTitle, style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                            Text('【${item.course.typefaceTitle}.钢笔】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                          ],
                        ),
                      ),
                      Text('${item.course.totalHours}课时', style: Styles.normalFont(fontSize: 26.sp)),
                      SizedBox(width: 30.w),
                    ],
                  ),
                  SizedBox(height: 17.w),
                  Text('学习时间：${item.course.learningTime}', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666), overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text('课程难度', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                          SizedBox(width: 10.w),
                          MiniRatingStar(rating: item.course.courseDifficulty.toDouble()),
                        ],
                      ),
                      Container(
                        width: 140.w,
                        height: 56.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(56.w)),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Text(item.isBuy == 1 ? '已购买' : '未购买', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15.w),
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 0.5, color: Color(0xFFF5F5F5))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: widget.showTags ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                        children: [
                          CommonAvatar(
                            size: 40.w,
                            showSex: false,
                            avatar: item.teacher.avatar,
                          ),
                          SizedBox(width: 15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.teacher.teacherName, style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                              widget.showTags
                                  ? Row(
                                      children: [
                                        ...List.generate(item.teacher.teacherLabel.length, (index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 4.w),
                                            margin: EdgeInsets.only(right: 20.w, top: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(36.w),
                                              color: Color(0xFFEEEEEE),
                                            ),
                                            child: Text(item.teacher.teacherLabel[index], style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999, height: 1.2)),
                                          );
                                        }),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text('${item.isBuy == 1 ? '已支付' : '课程价格'}\n¥${item.course.coursePrice}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.colorRed, fontWeight: FontWeight.bold, height: 1.5), textAlign: TextAlign.right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
