import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

import 'package:molan_edu/widgets/mini_rating_star.dart';

class CardLeaning extends StatefulWidget {
  CardLeaning({
    Key key,
  }) : super(key: key);

  _CardLeaningState createState() => _CardLeaningState();
}

class _CardLeaningState extends State<CardLeaning> {
  @override
  Widget build(BuildContext context) {
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
                Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                SizedBox(width: 10.w),
                Text('【楷书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                SizedBox(width: 10.w),
                Image.asset('assets/images/timetable/tag_vip.png', width: 67.8.w, height: 25.w),
              ],
            ),
            SizedBox(height: 23.w),
            Row(
              children: [
                Text('开课时间：每周一至周日', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34.w),
                    // color: Theme.of(context).accentColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                  child: Text(
                    '日更3课时',
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
                MiniRatingStar(rating: 3),
                Expanded(
                  child: Text(
                    '已学1节 剩余19节',
                    style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.w),
            Row(
              children: [
                CommonAvatar(size: 50.w),
                SizedBox(width: 20.w),
                Expanded(
                  child: Text('张杰老师', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
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
