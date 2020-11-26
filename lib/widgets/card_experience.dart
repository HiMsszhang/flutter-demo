import 'package:flutter/material.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:molan_edu/pages/timetable/timetable_list.dart';
import 'package:molan_edu/utils/imports.dart';

class CardExperience extends StatefulWidget {
  final double width;
  final double height;
  final ExperienceModel data;
  CardExperience({
    Key key,
    this.width,
    this.height,
    this.data,
  }) : super(key: key);

  _CardExperienceState createState() => _CardExperienceState();
}

class _CardExperienceState extends State<CardExperience> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, TimetableListPage(id: widget.data.id, title: widget.data.courseTitle));
      },
      child: UnconstrainedBox(
        child: Stack(
          children: [
            Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? double.infinity,
              padding: EdgeInsets.fromLTRB(26.w, 78.w, 180.w, 20.w),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home/bg_card.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(widget.data.courseTitle ?? '', style: Styles.normalFont(fontSize: 34.sp, color: Color(0xFFFF7E30), fontWeight: FontWeight.bold)),
                      SizedBox(width: 10.w),
                      Text(widget.data.typefaceTitle ?? '', style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFFF7E30))),
                    ],
                  ),
                  SizedBox(height: 17.w),
                  Text(
                    '${widget.data.teacherName}老师手把手教你${widget.data.courseCateTitle}',
                    style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.w),
                      border: Border.all(width: 1, color: Color(0xFFFF7E30)),
                    ),
                    child: Text(
                      '${(widget.data.duration ~/ 3600).toString()}小时 I ${widget.data.totalHours}节课',
                      style: Styles.normalFont(fontSize: 24.sp, color: Color(0xFFFF7E30), height: 1.2),
                    ),
                  ),
                  SizedBox(height: 33.w),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${widget.data.learnNum ?? 0}人学习',
                          style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 320.w,
                height: 50.w,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                child: Text(
                  widget.data.courseIntroduct ?? '',
                  style: Styles.normalFont(fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 26.w,
              child: Image.asset(
                'assets/images/home/pic_learning_girl.png',
                width: widget.width,
                height: widget.height - 80.w,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
