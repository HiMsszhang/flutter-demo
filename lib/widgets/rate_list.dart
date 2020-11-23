import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molan_edu/apis/teacher.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/TeacherModel.dart';
import 'package:molan_edu/pages/course/course_rate.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/card_rate.dart';

class RateList extends StatefulWidget {
  final int listLength;
  final int teacherId;
  final int courseId;
  RateList({
    Key key,
    this.listLength = 2,
    this.teacherId,
    this.courseId,
  }) : super(key: key);

  _RateListState createState() => _RateListState();
}

class _RateListState extends State<RateList> with UtilsMixin {
  int _selectedIndex = 0;
  int _labelId = 0;
  TeacherRateModel _data;
  bool _loadFlag = false;
  List<RateLabelModel> _labelList;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getList();
    });
  }

  _getList() async {
    DataResult res = await TeacherAPI.rateList(
      teacherId: widget.teacherId,
      courseId: widget.courseId,
      teacherLabelId: _labelId,
      page: 1,
      listRow: widget.listLength,
    );
    _data = res.data;
    _labelList = [
      RateLabelModel.fromJson({
        "id": 0,
        "label_title": "全部",
        "evaluate_num": _data.tatalEvaluateNum,
      }),
      ..._data.teacherLabel,
    ];
    _loadFlag = true;
    setState(() {});
  }

  _onOptionsTap(int index) async {
    setState(() {
      _selectedIndex = index;
      _labelId = _labelList[index].id;
    });
    await _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14.w),
      child: _loadFlag
          ? Column(
              children: [
                Container(
                  width: 690.w,
                  padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 40.w),
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Image.asset('assets/images/common/icon_edit.png', width: 34.w, height: 31.w),
                              SizedBox(width: 17.w),
                              Text('学员评价', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                              SizedBox(width: 6.w),
                              Text('（${_data?.tatalEvaluateNum}个评价）', style: Styles.normalFont(fontSize: 24.sp)),
                            ],
                          ),
                          Text('学生喜爱度:${_data?.likeability}%', style: Styles.specialFont(fontSize: 30.sp, color: Theme.of(context).accentColor)),
                        ],
                      ),
                      SizedBox(height: 30.w),
                      _widgetOptions(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Container(
                    width: 690.w,
                    child: Column(
                      children: [
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => CardRate(data: _data?.evaluateList?.data[index]),
                          separatorBuilder: (context, index) => Container(
                            width: 636.w,
                            height: 1,
                            color: Color(0xFFF6F6F7),
                            margin: EdgeInsets.symmetric(horizontal: 30.w),
                          ),
                          itemCount: _data?.evaluateList?.data?.length ?? 0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                NavigatorUtils.push(
                                    context,
                                    CourseRatePage(
                                      teacherId: widget.teacherId,
                                      courseId: widget.courseId,
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.w),
                                margin: EdgeInsets.symmetric(vertical: 30.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48.w),
                                  color: Color(0xFFF5F5F5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  children: [
                                    Text('查看更多学员评价', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999)),
                                    SizedBox(width: 10.w),
                                    Transform.rotate(
                                      angle: -pi / 2,
                                      child: Icon(Icons.arrow_back_ios, size: 22.w, color: Styles.color999999),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : MyLoading(),
    );
  }

  Widget _widgetOptions() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 13.w,
      runSpacing: 22.w,
      children: List.generate(_labelList.length ?? 0, (index) {
        var item = _labelList[index];
        return InkWell(
          onTap: () async {
            await _onOptionsTap(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 11.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.w),
              color: _selectedIndex == index ? Theme.of(context).accentColor : Color(0xFFF5F5F5),
            ),
            child: Text(
              '${item?.labelTitle}x${item?.evaluateNum}',
              style: Styles.normalFont(fontSize: 26.sp, color: _selectedIndex == index ? Colors.white : Styles.color999999),
            ),
          ),
        );
      }),
    );
  }
}
