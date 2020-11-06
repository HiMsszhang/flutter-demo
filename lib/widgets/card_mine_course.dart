import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';

class CardMineCourse extends StatefulWidget {
  final bool showTags;
  CardMineCourse({
    Key key,
    this.showTags = false,
  }) : super(key: key);

  _CardMineCourseState createState() => _CardMineCourseState();
}

class _CardMineCourseState extends State<CardMineCourse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        onPressed: () {},
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
                            Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                            Text('【楷书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                          ],
                        ),
                      ),
                      Text('20课', style: Styles.normalFont(fontSize: 26.sp)),
                      SizedBox(width: 30.w),
                    ],
                  ),
                  SizedBox(height: 17.w),
                  Text('学习时间：周一至周五 11:00-12:00', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666), overflow: TextOverflow.ellipsis),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Text('课程难度', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                          SizedBox(width: 10.w),
                          MiniRatingStar(rating: 3),
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
                        child: Text('学习中', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 21.w),
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
                          ),
                          SizedBox(width: 15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Vicky老师', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                              widget.showTags
                                  ? Row(
                                      children: [
                                        ...List.generate(
                                          2,
                                          (index) => Container(
                                            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 4.w),
                                            margin: EdgeInsets.only(right: 20.w, top: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(36.w),
                                              color: Color(0xFFEEEEEE),
                                            ),
                                            child: Text('3年教龄', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999, height: 1.2)),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text('已支付\n￥999.00', style: Styles.normalFont(fontSize: 24.sp, color: Styles.colorRed, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
