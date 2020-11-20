import 'package:flutter/material.dart';
import 'package:molan_edu/apis/course.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/pages/course/course_detail.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/mini_rating_star.dart';

class RecommendList extends StatefulWidget {
  RecommendList({
    Key key,
    this.courseCateId,
    this.typefaceId,
  }) : super(key: key);
  final courseCateId;
  final typefaceId;

  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  List<CourseRecommendModle> _courseRecommendList = [];

  Future<List<CourseRecommendModle>> _getCourseRecommendList() async {
    DataResult result = await CourseAPI.courserecommendlist(
      courseCateId: widget.courseCateId,
      typefaceId: widget.typefaceId,
    );
    return _courseRecommendList = result.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCourseRecommendList(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            width: 750.w,
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.w),
            child: Column(
              children: [
                Container(
                  width: 690.w,
                  height: 93.w,
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 28.w),
                      Image.asset('assets/images/common/icon_recommend.png', width: 30.w, height: 30.w),
                      SizedBox(width: 18.w),
                      Text(S.current.recommend, style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ...List.generate(_courseRecommendList.length, (index) => _widgetItem(index)),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _widgetItem(int index) {
    var item = _courseRecommendList[index];
    return Container(
      margin: EdgeInsets.only(top: 14.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        onPressed: () {
          NavigatorUtils.push(context, CourseDetailPage(courseId: item.id));
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 31.w).copyWith(bottom: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 135.w,
                    height: 165.w,
                    clipBehavior: Clip.hardEdge,
                    margin: EdgeInsets.only(right: 20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    child: Image.network(item.avatar, fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${item.courseTitle}', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                            Text('【${item.typefaceTitle}.${item.courseCateTitle}】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 17.w),
                        Text(
                          item.courseIntroduct,
                          style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 15.w),
                        Text(
                          '讲师：${item.teacherName ?? ''}',
                          style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999),
                        ),
                        SizedBox(height: 11.w),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: Color(0xFFF2F2F2),
                              ),
                              child: Text(
                                '${item.totalHours}课时',
                                style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666, height: 1.2),
                              ),
                            ),
                            Text('￥${item.coursePrice}', style: Styles.normalFont(fontSize: 36.sp, color: Styles.colorRed, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 21.w),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 0.5, color: Color(0xFFF5F5F5))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('课程难度', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                      SizedBox(width: 10.w),
                      MiniRatingStar(rating: item.courseDifficulty.toDouble()),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/common/icon_learn.png', width: 26.w, height: 20.w),
                      SizedBox(width: 9.w),
                      Text('${item.learnNum}W人', style: Styles.normalFont(fontSize: 22.sp, color: Styles.colorBlue)),
                    ],
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
