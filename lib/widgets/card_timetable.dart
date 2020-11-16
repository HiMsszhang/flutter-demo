import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/models/TimeTableModel.dart';
import 'package:molan_edu/pages/timetable/timetable_detail.dart';

class CardTimetable extends StatefulWidget {
  final TimeTableMenuModel data;
  //课程学习模式 1--普通 2--VIP
  final int courseModelId;

  CardTimetable({
    Key key,
    this.data,
    this.courseModelId,
  }) : super(key: key);

  _CardTimetableState createState() => _CardTimetableState();
}

class _CardTimetableState extends State<CardTimetable> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
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
          if (data.isLock == 2) return;
          NavigatorUtils.push(context, TimetableDetailPage(id: data.id, title: data.courseCatalogueTitle));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.courseArrangement ?? '', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                  SizedBox(height: 21.w),
                  Row(
                    children: [
                      Text(data.courseCatalogueTitle ?? '', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 54.w),
                  data.isLock == 2 ? _widgetLock() : _widgetLearn(),
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
                  CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: data.image ?? '',
                    placeholder: (context, url) => Image.asset('assets/images/demo.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Offstage(
                      offstage: data.lastLearningStatus == 2,
                      child: Container(
                        width: 180.w,
                        height: 35.w,
                        alignment: Alignment.center,
                        color: Theme.of(context).accentColor,
                        child: Text('上次学到', style: Styles.normalFont(fontSize: 22.sp, color: Colors.white)),
                      ),
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
          widget.courseModelId == 1 ? 2 : 3,
          (index) => Container(
            margin: EdgeInsets.only(right: 30.w),
            child: ImageIcon(
              AssetImage('assets/images/timetable/icon_learn.png'),
              size: 41.w,
              color: widget.data.completionStatus > index ? Theme.of(context).accentColor : Color(0xFFD7D7D7),
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
            color: widget.data.completionStatus == 3 ? Theme.of(context).accentColor : Color(0xFFD7D7D7),
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
        Text('${widget.data.openingTime}  开始学习哦', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
      ],
    );
  }
}
