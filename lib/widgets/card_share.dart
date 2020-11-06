import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class CardShare extends StatefulWidget {
  CardShare({
    Key key,
  }) : super(key: key);

  _CardShareState createState() => _CardShareState();
}

class _CardShareState extends State<CardShare> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF5F5F5))),
        color: Theme.of(context).primaryColor,
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 30.w).copyWith(bottom: 30.w),
        onPressed: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonAvatar(size: 72.w),
                SizedBox(width: 18.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('lucky老师', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12.w),
                    Text('2020-10-12', style: Styles.normalFont(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Styles.color666666)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.w),
            Text(
              '小学生偏旁部首的重要性，我来告诉你！小学生偏旁部首的重要性，我来告诉你！小学生偏旁部首的重要性，我来告诉你！',
              style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.5),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20.w),
            Container(
              width: 690.w,
              height: 406.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Image.asset('assets/images/demo.png', fit: BoxFit.cover),
            ),
            SizedBox(height: 28.w),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('assets/images/course/icon_share_see.png', width: 38.w, height: 23.w, fit: BoxFit.contain),
                      SizedBox(width: 13.w),
                      Text('888', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/images/course/icon_share_like.png', width: 30.w, height: 30.w, fit: BoxFit.contain),
                      SizedBox(width: 13.w),
                      Text('888', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Image.asset('assets/images/course/icon_share_comment.png', width: 30.w, height: 30.w, fit: BoxFit.contain),
                //       SizedBox(width: 13.w),
                //       Text('888', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
