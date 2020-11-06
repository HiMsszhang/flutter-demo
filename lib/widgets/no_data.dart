import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class NoData extends StatefulWidget {
  NoData({
    Key key,
  }) : super(key: key);

  _NoDataState createState() => _NoDataState();
}

class _NoDataState extends State<NoData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: 200.w),
      color: Color(0xFFFFF7F3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/common/no_data_course.png', width: 435.w, height: 395.w, fit: BoxFit.contain),
          SizedBox(height: 80.w),
          Text('还未收藏任何老师哦', style: Styles.normalFont(fontSize: 30.sp, color: Styles.colorNoData)),
        ],
      ),
    );
  }
}
