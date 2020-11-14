import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class NoData extends StatefulWidget {
  final String text;
  final String url;
  NoData({
    Key key,
    this.text = '没搜索到相关的课程哦',
    this.url,
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
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(widget.url ?? 'assets/images/common/no_data_course.png', width: 435.w, height: 395.w, fit: BoxFit.contain),
          SizedBox(height: 80.w),
          Text(widget.text ?? '', style: Styles.normalFont(fontSize: 30.sp, color: Styles.colorNoData)),
        ],
      ),
    );
  }
}
