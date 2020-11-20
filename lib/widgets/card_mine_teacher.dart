import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:molan_edu/apis/mine.dart';
=======
import 'package:molan_edu/models/TeacherModel.dart';
>>>>>>> 2c68d95022d95c33f6c167b6f790602bc581373c
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class CardMineTeacher extends StatefulWidget {
  final bool showTags;
  final TeacherModel data;
  CardMineTeacher({
    Key key,
    this.showTags = false,
    this.data,
  }) : super(key: key);

  _CardMineTeacherState createState() => _CardMineTeacherState();
}

class _CardMineTeacherState extends State<CardMineTeacher> {
  bool _isCollection = true;
  Future _getTeacherCollection() async {
    DataResult result = await MineApi.teacherCollection(
      teacherId: 1,
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.data;
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
                        showSex: false,
                        size: 90.w,
                        avatar: item?.avatar ?? '',
                      ),
                      SizedBox(width: 22.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item?.teacherName ?? '', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                            SizedBox(height: 18.w),
                            Text('学生喜爱度${item?.likeability}%', style: Styles.specialFont(fontSize: 26.sp, color: Theme.of(context).accentColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _getTeacherCollection();
                    setState(() {
                      _isCollection = !_isCollection;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 46.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(46.w),
                      border: Border.all(width: 2.w, color: Theme.of(context).accentColor),
                    ),
                    child: Text(_isCollection == true ? '取消收藏' : '收藏', style: Styles.normalFont(fontSize: 26.sp, color: Theme.of(context).accentColor, height: 1.2)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 36.w),
            Container(
              height: 80.w,
              child: Text(item?.introduce ?? '', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666, height: 1.38)),
            ),
            widget.showTags
                ? Container(
                    margin: EdgeInsets.only(top: 20.w),
                    child: Wrap(
                      spacing: 18.w,
                      runSpacing: 10.w,
                      children: List.generate(
                        item?.teacherLabel?.length ?? 0,
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
                              Text(item?.teacherLabel[index] ?? '', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
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
