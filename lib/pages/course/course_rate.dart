import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_rate.dart';
import 'package:molan_edu/models/TeacherModel.dart';
import 'package:molan_edu/apis/teacher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CourseRatePage extends StatefulWidget {
  final int teacherId;
  final int courseId;
  const CourseRatePage({
    Key key,
    this.teacherId,
    this.courseId,
  }) : super(key: key);

  @override
  _CourseRatePageState createState() => _CourseRatePageState();
}

class _CourseRatePageState extends State<CourseRatePage> with UtilsMixin {
  int _selectedIndex = 0;
  int _labelId = 0;
  TeacherRateModel _info;
  RateListResp _data;
  List<RateModel> _dataList;
  bool _loadFlag = false;
  List<RateLabelModel> _labelList;
  RefreshController _listController = RefreshController(initialRefresh: false);

  int _page = 1;
  int _listRow = 10;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getFirstList();
    });
  }

  _getFirstList() async {
    DataResult res = await TeacherAPI.rateList(
      teacherId: widget.teacherId,
      courseId: widget.courseId,
      teacherLabelId: _labelId,
      page: _page,
      listRow: _listRow,
    );
    _info = res.data;
    _labelList = [
      RateLabelModel.fromJson({
        "id": 0,
        "label_title": "全部",
        "evaluate_num": _info.tatalEvaluateNum,
      }),
      ..._info.teacherLabel,
    ];
    _data = _info.evaluateList;
    _dataList = _data.data;
    _loadFlag = true;
    setState(() {});
  }

  Future<List<RateModel>> _getList() async {
    DataResult result = await TeacherAPI.rateList(
      teacherId: widget.teacherId,
      courseId: widget.courseId,
      teacherLabelId: _labelId,
      page: _page,
      listRow: _listRow,
    );
    _data = result.data.evaluateList;
    return _data.data;
  }

  void _onRefresh() async {
    _page = 1;
    _dataList = await _getList();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    if (_data.lastPage == _page || _data.lastPage == 0) {
      _listController.loadNoData();
    } else {
      _page++;
      _dataList.addAll(await _getList());
      _listController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  _onOptionsTap(int index) async {
    setState(() {
      _selectedIndex = index;
      _labelId = _labelList[index].id;
    });
    _listController.requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '学员评价',
      backgroundColor: Theme.of(context).primaryColor,
      body: _loadFlag
          ? SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _listController,
              header: myCustomHeader(),
              footer: myCustomFooter(),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
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
                                Text('（${_info?.tatalEvaluateNum}个评价）', style: Styles.normalFont(fontSize: 24.sp)),
                              ],
                            ),
                            Text('学生喜爱度:${_info?.likeability}%', style: Styles.specialFont(fontSize: 30.sp, color: Theme.of(context).accentColor)),
                          ],
                        ),
                        SizedBox(height: 30.w),
                        _widgetOptions(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 14.w),
                    clipBehavior: Clip.hardEdge,
                    decoration: Styles.normalDecoration.copyWith(
                      borderRadius: BorderRadius.circular(16.w),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => CardRate(data: _dataList[index]),
                      separatorBuilder: (context, index) => Container(
                        width: 636.w,
                        height: 1,
                        color: Color(0xFFF6F6F7),
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                      ),
                      itemCount: _dataList?.length ?? 0,
                    ),
                  ),
                ],
              ),
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
