import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

import 'package:molan_edu/widgets/mini_rating_star.dart';
import 'package:molan_edu/models/TimeTableModel.dart';

class CardLeaning extends StatefulWidget {
  final TimeTableModel data;
  CardLeaning({
    Key key,
    this.data,
  }) : super(key: key);

  _CardLeaningState createState() => _CardLeaningState();
}

class _CardLeaningState extends State<CardLeaning> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Container(
      width: 690.w,
      margin: EdgeInsets.only(bottom: 20.w),
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
        color: Theme.of(context).primaryColor,
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.all(30.w),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          NavigatorUtils.pushNamed(context, '/timetable.list');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(data?.courseTitle ?? '', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                SizedBox(width: 10.w),
                Text('【${data?.typefaceTitle}.${data?.courseCateTitle}】', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                SizedBox(width: 10.w),
                data?.courseModelId == 2 ? Image.asset('assets/images/timetable/tag_vip.png', width: 67.8.w, height: 25.w) : Container(),
              ],
            ),
            SizedBox(height: 23.w),
            Row(
              children: [
                Text('开课时间：${data?.learningTime}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34.w),
                    // color: Theme.of(context).accentColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  child: Text(
                    '日更${data?.dailyUpdate}课时',
                    style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.w),
            Row(
              children: [
                Text('课程难度', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                SizedBox(width: 10.w),
                MiniRatingStar(rating: data.courseDifficulty.toDouble() ?? 0),
                Expanded(
                  child: Text(
                    '已学${data?.learnedNum}节 剩余${data?.surplusNum}节',
                    style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.w),
            Row(
              children: [
                CommonAvatar(
                  size: 50.w,
                  avatar: data?.avatar ?? '',
                  showSex: false,
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Text('${data?.teacherName}老师', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                ),
                Container(
                  width: 162.w,
                  height: 48.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(48.w),
                    color: Theme.of(context).accentColor,
                  ),
                  child: RawMaterialButton(
                    constraints: BoxConstraints(minHeight: 162.w, minWidth: 48.w),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {},
                    child: Text('继续学习', style: Styles.normalFont(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.bold)),
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
