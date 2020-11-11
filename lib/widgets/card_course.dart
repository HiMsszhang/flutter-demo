import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/mini_rating_star.dart';
import 'package:molan_edu/models/CourseModel.dart';

class CardCourse extends StatefulWidget {
  final double width;
  final double height;
  final int colorType;
  final CourseModel data;
  CardCourse({
    Key key,
    this.width,
    this.height,
    this.colorType = 1,
    this.data,
  }) : super(key: key);

  _CardCourseState createState() => _CardCourseState();
}

class _CardCourseState extends State<CardCourse> with UtilsMixin {
  _cardTheme() {
    Map theme1 = {
      'btnTextColor': Color(0xFFAD7C5D),
      'priceColor': Color(0xFFB7571B),
      'btnColor': Color(0xFFF08556),
      'nameColor': Color(0xFFA37B62),
      'infoColor': Color(0xFFA37B62),
    };
    Map theme2 = {
      'btnTextColor': Color(0xFF718DBA),
      'priceColor': Color(0xFF5579B7),
      'btnColor': Color(0xFF6F98DF),
      'nameColor': Color(0xFF5579B7),
      'infoColor': Color(0xFF718DBA),
    };
    Map theme3 = {
      'btnTextColor': Color(0xFFB37878),
      'priceColor': Color(0xFFBD4343),
      'btnColor': Color(0xFFDF6F84),
      'nameColor': Color(0xFFB37878),
      'infoColor': Color(0xFFB37878),
    };
    switch (widget.colorType) {
      case 1:
        return theme1;
        break;
      case 2:
        return theme2;
        break;
      case 3:
        return theme3;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.data;
    return GestureDetector(
      onTap: () {
        NavigatorUtils.pushNamed(context, '/course.detail', arguments: {'courseId': 1});
      },
      child: UnconstrainedBox(
        child: Stack(
          children: [
            Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w).copyWith(bottom: 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/course/bg_card_${widget.colorType}.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(item?.courseTitle ?? '', style: Styles.normalFont(fontSize: 32.sp, color: Colors.white)),
                            Text('【${item?.typefaceTitle}.${item?.courseCateTitle}】', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 20.w),
                        Container(
                          width: 345.w,
                          child: RichText(
                            text: TextSpan(
                              style: Styles.normalFont(fontSize: 24.sp, color: Colors.white, height: 1.4),
                              children: [
                                TextSpan(text: '开课时间：${item?.learningTime}'),
                                WidgetSpan(
                                  child: SizedBox(width: 16.w, height: 16.w),
                                ),
                                WidgetSpan(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(34.w),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                                    child: Text(
                                      '日更${item?.dailyUpdate}课时',
                                      style: Styles.normalFont(fontSize: 22.sp, color: _cardTheme()['btnTextColor'], height: 1.2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 14.w),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('课程难度', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                            SizedBox(width: 10.w),
                            MiniRatingStar(
                              rating: item?.courseDifficulty?.toDouble() ?? 0,
                              color: Colors.white,
                              showAllStar: false,
                            ),
                            InkWell(
                              onTap: () {
                                courseInfoPopup(context, widget.data);
                              },
                              child: Container(
                                width: 30.w,
                                height: 30.w,
                                margin: EdgeInsets.all(10.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.w),
                                  color: Color(0xFF87B4FF),
                                ),
                                child: Text('?', style: TextStyle(fontSize: 24.sp, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.w),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('￥${item?.coursePrice}', style: Styles.normalFont(fontSize: 30.sp, color: _cardTheme()['priceColor'], fontWeight: FontWeight.bold)),
                                SizedBox(width: 15.w),
                                Text('(${item?.totalHours}课时)', style: Styles.normalFont(fontSize: 22.sp, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 162.w,
                          height: 48.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48.w),
                            color: _cardTheme()['btnColor'],
                          ),
                          child: Text('马上报名', style: Styles.normalFont(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 40.w),
                      ],
                    ),
                  ),
                  Container(
                    width: 177.w,
                    height: 341.w,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: item?.avatar ?? '',
                      placeholder: (context, url) => Container(color: Colors.transparent),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 26.w,
                    child: Text(
                      '${item?.teacherName}老师',
                      style: Styles.normalFont(fontSize: 28.sp, color: _cardTheme()['nameColor'], fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 22.w,
                    child: Text(
                      '${item?.evaluate}',
                      style: Styles.normalFont(fontSize: 22.sp, color: _cardTheme()['infoColor'], height: 1.2),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
