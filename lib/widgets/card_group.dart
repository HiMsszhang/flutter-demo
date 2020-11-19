import 'package:flutter/material.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/pages/course/course_detail.dart';

class CardGroup extends StatefulWidget {
  final double width;
  final double height;
  final GroupCourseModel data;
  CardGroup({
    Key key,
    this.width,
    this.height,
    this.data,
  }) : super(key: key);

  _CardGroupState createState() => _CardGroupState();
}

class _CardGroupState extends State<CardGroup> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return GestureDetector(
      onTap: () {
        NavigatorUtils.push(context, CourseDetailPage(isGroup: true, courseId: data.id));
      },
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? double.infinity,
        padding: EdgeInsets.fromLTRB(26.w, 26.w, 20.w, 20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16.w),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(163, 163, 163, 0.2),
              blurRadius: 30.w,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 175.w,
                    height: 222.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          imageUrl: data?.avatar ?? '',
                          placeholder: (context, url) => Image.asset('assets/images/placeholder.png', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 43.w,
                            color: Color.fromRGBO(162, 162, 162, .6),
                            alignment: Alignment.center,
                            child: Text('${data?.totalHours}课时', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 17.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(data?.courseTitle ?? '', style: Styles.normalFont(fontSize: 30.sp, color: Styles.colorText, fontWeight: FontWeight.bold)),
                            SizedBox(width: 14.w),
                            Text('【${data?.typefaceTitle}.${data?.courseCateTitle}】', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                          ],
                        ),
                        SizedBox(height: 20.w),
                        Container(
                          width: 450.w,
                          height: 80.w,
                          child: Wrap(
                            spacing: 14.w, //主轴上子控件的间距
                            runSpacing: 16.w, //交叉轴上子控件之间的间距
                            children: List.generate(
                              data?.teacherLabel?.length ?? 0,
                              (index) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.w),
                                decoration: BoxDecoration(color: Color(0xFFEDEDED), borderRadius: BorderRadius.circular(31.w)),
                                child: Text(data?.teacherLabel[index] ?? '', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color666666, height: 1.2)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '早鸟拼团价：',
                                  style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666),
                                ),
                                SizedBox(height: 14.w),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '￥${data?.marketPrice}',
                                      style: Styles.normalFont(fontSize: 30.sp, color: Styles.colorRed, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      '￥${data?.coursePrice}',
                                      style: Styles.normalFont(fontSize: 22.sp, color: Color(0xFFB2B2B2), decoration: TextDecoration.lineThrough),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              width: 145.w,
                              height: 51.w,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 4.w),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/common/btn_bg.png'),
                                  ),
                                  borderRadius: BorderRadius.circular(51.w),
                                  boxShadow: [
                                    BoxShadow(color: Color.fromRGBO(178, 132, 100, 0.33), offset: Offset(2.w, 3.w), blurRadius: 20.w, spreadRadius: 1.w),
                                  ]),
                              child: Text(
                                '立即参团',
                                style: Styles.normalFont(fontSize: 28.sp, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 650.w,
              height: 1,
              color: Color(0xFFF5F5F5),
              margin: EdgeInsets.only(bottom: 20.w),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '开课时间：${data?.openingTime}',
                    style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 2.w,
                  height: 10.w,
                  color: Styles.color666666,
                ),
                Expanded(
                  child: Text(
                    '${data?.learningTime}   日更${data?.dailyUpdate}课时',
                    style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
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
