import 'package:flutter/material.dart';
import 'package:molan_edu/apis/course.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/mini_rating_star.dart';

class RecommendList extends StatefulWidget {
  RecommendList({
    Key key,
  }) : super(key: key);

  _RecommendListState createState() => _RecommendListState();
}

class _RecommendListState extends State<RecommendList> {
  CourseRecommendModleList _courseRecommendData;

  Future _getCourseRecommendList() async {
    DataResult result = await CourseAPI.courserecommendlist(
      courseCateId: 1,
      typefaceId: 1,
    );
    _courseRecommendData = result.data[0];
  }

  @override
  Widget build(BuildContext context) {
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
                Text(S.current.recommend, style: Styles.specialFont(fontSize: 32.sp)),
              ],
            ),
          ),
          ...List.generate(3, (index) => _widgetItem(index)),
        ],
      ),
    );
  }

  Widget _widgetItem(int index) {
    return FutureBuilder(
      future: _getCourseRecommendList(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var item = _courseRecommendData;
          return Container(
            margin: EdgeInsets.only(top: 14.w),
            clipBehavior: Clip.hardEdge,
            decoration: Styles.normalDecoration.copyWith(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: RawMaterialButton(
              onPressed: () {},
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
                          child: Image.asset('assets/images/demo.png', fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${item.data}', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                                  Text('【楷书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 17.w),
                              Text(
                                '文字介绍文字介绍文字介绍文字介绍文文文字介绍文字介绍文字介绍文字介绍文文',
                                style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 15.w),
                              Text(
                                '讲师：licky老师',
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
                                      '20课时',
                                      style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666, height: 1.2),
                                    ),
                                  ),
                                  Text('￥1212.00', style: Styles.normalFont(fontSize: 36.sp, color: Styles.colorRed, fontWeight: FontWeight.bold)),
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
                            MiniRatingStar(rating: 3),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/common/icon_learn.png', width: 26.w, height: 20.w),
                            SizedBox(width: 9.w),
                            Text('321W人', style: Styles.normalFont(fontSize: 22.sp, color: Styles.colorBlue)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
