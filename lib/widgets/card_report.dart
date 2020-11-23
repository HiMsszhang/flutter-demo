import 'package:flutter/material.dart';
import 'package:molan_edu/models/ReportModel.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';

class CardReport extends StatefulWidget {
  /// 是否提交
  final bool hasLearn;
  final MyReportModel data;
  CardReport({
    Key key,
    this.hasLearn = true,
    this.data,
  }) : super(key: key);

  _CardReportState createState() => _CardReportState();
}

class _CardReportState extends State<CardReport> {
  _isEpic() {
    if (widget.data == null) return false;
    var data = widget?.data;
    var total = data.integrity + data.neatness + data.beauty;
    if (total >= 13) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 690.w,
      margin: EdgeInsets.only(bottom: 20.w),
      padding: EdgeInsets.all(30.w),
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: widget.hasLearn ? _widgetLearn() : _widgetNoLearn(),
    );
  }

  Widget _widgetLearn() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CommonAvatar(size: 60.w, showSex: false, avatar: widget?.data?.avatar ?? ''),
                  SizedBox(width: 14.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget?.data?.name ?? '', style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.w),
                      Text('${widget?.data?.createTime} ${widget?.data?.week}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Image.asset('assets/images/mine/rank_${_isEpic() ? "epic" : "good"}.png', width: 32.w, height: 32.w),
                SizedBox(width: 12.w),
                Text(_isEpic() ? '优秀' : '良', style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Color(0xFFFFA06B))),
              ],
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 0.5,
          color: Color(0xFFF5F5F5),
          margin: EdgeInsets.symmetric(vertical: 20.w),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget?.data?.courseCatalogueTitle ?? '', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.w),
                  Text('${widget?.data?.teacherName ?? ''}老师的点评', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                  SizedBox(height: 20.w),
                  Row(
                    children: [
                      Text('完整度：', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                      MiniRatingStar(rating: widget?.data?.integrity?.toDouble()),
                    ],
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    children: [
                      Text('工整度：', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                      MiniRatingStar(rating: widget?.data?.neatness?.toDouble()),
                    ],
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    children: [
                      Text('美观度：', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                      MiniRatingStar(rating: widget?.data?.beauty?.toDouble()),
                    ],
                  ),
                ],
              ),
            ),
            ...List.generate(
              widget?.data?.image?.length ?? 0,
              (index) => Container(
                width: 162.w,
                height: 192.w,
                margin: EdgeInsets.only(left: 14.w),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w)),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: widget?.data?.image[index] ?? '',
                  placeholder: (context, url) => Image.asset('assets/images/placeholder.png', width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetNoLearn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text('第一节', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
        ),
        SizedBox(height: 11.w),
        Image.asset('assets/images/mine/pic_report.png', width: 211.w, height: 114.w),
        SizedBox(height: 20.w),
        Text('本次作业尚未提交', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
        SizedBox(height: 11.w),
        Text('待您提交后老师将更新报告内容', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
      ],
    );
  }
}
