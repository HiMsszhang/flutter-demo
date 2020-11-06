import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class CardTimetable extends StatefulWidget {
  final bool isLock;
  final VoidCallback onTap;

  CardTimetable({
    Key key,
    this.isLock = true,
    this.onTap,
  }) : super(key: key);

  _CardTimetableState createState() => _CardTimetableState();
}

class _CardTimetableState extends State<CardTimetable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 690.w,
      margin: EdgeInsets.only(bottom: 20.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
        color: Theme.of(context).primaryColor,
      ),
      child: RawMaterialButton(
        padding: EdgeInsets.all(30.w),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          widget.onTap();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('第一节', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                  SizedBox(height: 21.w),
                  Row(
                    children: [
                      Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                      Text('【楷书.钢笔】', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                    ],
                  ),
                  SizedBox(height: 54.w),
                  widget.isLock ? _widgetLock() : _widgetLearn(),
                ],
              ),
            ),
            Container(
              width: 180.w,
              height: 170.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Stack(
                children: [
                  Image.asset('assets/images/demo.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 180.w,
                      height: 35.w,
                      alignment: Alignment.center,
                      color: Theme.of(context).accentColor,
                      child: Text('上次学到', style: Styles.normalFont(fontSize: 22.sp, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _widgetLearn() {
    return Row(
      children: [
        ...List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(right: 30.w),
            child: ImageIcon(
              AssetImage('assets/images/timetable/icon_learn.png'),
              size: 41.w,
              color: Color(0xFFD7D7D7),
            ),
          ),
        ),
        Container(
          width: 4.w,
          height: 14.w,
          color: Color(0xFFD7D7D7),
          margin: EdgeInsets.only(left: 10.w, right: 40.w),
        ),
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.w),
            color: Color(0xFFD7D7D7),
          ),
          child: Icon(
            Icons.check,
            size: 30.w,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _widgetLock() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/images/common/icon_lock.png',
          width: 35.w,
          height: 41.w,
        ),
        SizedBox(width: 18.w),
        Text('12-03  开始学习哦', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
      ],
    );
  }
}
