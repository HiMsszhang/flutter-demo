import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class CardMineTeacher extends StatefulWidget {
  final bool showTags;
  CardMineTeacher({
    Key key,
    this.showTags = false,
  }) : super(key: key);

  _CardMineTeacherState createState() => _CardMineTeacherState();
}

class _CardMineTeacherState extends State<CardMineTeacher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 690.w,
      margin: EdgeInsets.only(bottom: 20.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.all(30.w),
        onPressed: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CommonAvatar(
                        size: 90.w,
                      ),
                      SizedBox(width: 22.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('licky老师', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 18.w),
                            Text('学生喜爱度99.5%', style: Styles.specialFont(fontSize: 26.sp, color: Theme.of(context).accentColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 46.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(46.w),
                      border: Border.all(width: 2.w, color: Theme.of(context).accentColor),
                    ),
                    child: Text('取消收藏', style: Styles.normalFont(fontSize: 26.sp, color: Theme.of(context).accentColor, height: 1.2)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 36.w),
            Container(
              height: 80.w,
              child: Text('北京大学，硕士，三年教龄，风趣幽默，有责任心，让课程变的生动。', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666, height: 1.38)),
            ),
            widget.showTags
                ? Container(
                    margin: EdgeInsets.only(top: 20.w),
                    child: Wrap(
                      spacing: 18.w,
                      runSpacing: 10.w,
                      children: List.generate(
                        7,
                        (index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          height: 41.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(41.w),
                            color: Color(0xFFEBEBEB),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('博士', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
