import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molan_edu/apis/report.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/ReportModel.dart';
import 'package:molan_edu/pages/mine/mine_report_detail.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_report.dart';
import 'package:molan_edu/widgets/no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineReportPage extends StatefulWidget {
  const MineReportPage({
    Key key,
  }) : super(key: key);

  @override
  _MineReportPageState createState() => _MineReportPageState();
}

class _MineReportPageState extends State<MineReportPage> with UtilsMixin {
  bool _isFilterShow = false;
  bool _loadFlag = false;
  int _selectedIndex = 0;

  RefreshController _courseController = RefreshController(initialRefresh: false);
  ReportCourseListResp _courseData;
  List<ReportCourseModel> _courseList;
  int _coursePage = 1;
  int _courseLimit = 10;

  RefreshController _reportController = RefreshController(initialRefresh: false);
  MyReportListResp _reportData;
  List<MyReportModel> _reportList;
  int _reportPage = 1;
  int _reportLimit = 10;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      _courseList = await _getCourseList();
      await _reportController.requestRefresh();
      setState(() {});
    });
  }

  Future<List<ReportCourseModel>> _getCourseList() async {
    DataResult res = await ReportAPI.courseList(page: _coursePage, listRow: _courseLimit);
    _courseData = res.data;
    return _courseData.data;
  }

  void _onCourseLoading() async {
    if (_courseData.lastPage == _coursePage || _courseData.lastPage == 0) {
      _courseController.loadNoData();
    } else {
      _coursePage++;
      _courseList.addAll(await _getCourseList());
      _courseController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  Future<List<MyReportModel>> _getReportList() async {
    DataResult res = await ReportAPI.list(page: _reportPage, listRow: _reportLimit, courseId: _courseList?.elementAt(_selectedIndex)?.courseId);
    _reportData = res.data;
    return _reportData.data;
  }

  void _onReportRefresh() async {
    _reportPage = 1;
    _reportList = await _getReportList();
    setState(() {});
    _reportController.refreshCompleted();
  }

  void _onReportLoading() async {
    if (_reportData.lastPage == _reportPage || _reportData.lastPage == 0) {
      _reportController.loadNoData();
    } else {
      _reportPage++;
      _reportList.addAll(await _getReportList());
      _reportController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  _hideFilter(int index) {
    setState(() {
      _selectedIndex = index;
      _isFilterShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      actionTitle: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_courseData?.total == 0 ? '我的报告' : '${_courseList?.elementAt(_selectedIndex)?.courseTitle ?? ''}', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
            _courseData?.total == 0
                ? Container()
                : Transform.rotate(
                    angle: _isFilterShow ? -(pi / 2) : (pi / 2),
                    child: Icon(Icons.play_arrow, size: 34.w, color: Styles.color999999),
                  ),
          ],
        ),
        onTap: () {
          setState(() {
            _isFilterShow = !_isFilterShow;
          });
        },
      ),
      actions: [
        Opacity(
          opacity: _courseData?.total == 0 ? 0 : 1,
          child: IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/mine/icon_mine_report.png'),
              size: 33.w,
            ),
            onPressed: () {
              if (_courseData?.total == 0) return;
              NavigatorUtils.push(context, MineReportDetailPage(id: _courseList?.elementAt(_selectedIndex)?.courseId));
            },
          ),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          _courseData?.total == 0
              ? NoData(
                  text: '暂无报告\nVIP模式将为您提供成长报告',
                  url: "assets/images/mine/report_no_data.png",
                  backgroundColor: Color(0xFFFFFAF7),
                )
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: _onReportRefresh,
                  onLoading: _onReportLoading,
                  controller: _reportController,
                  header: myCustomHeader(),
                  footer: myCustomFooter(),
                  child: ListView(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                        itemCount: _reportList?.length ?? 1,
                        itemBuilder: (context, index) => CardReport(),
                      ),
                    ],
                  ),
                ),
          _isFilterShow
              ? Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      _isFilterShow = false;
                      setState(() {});
                    },
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                )
              : Container(),
          filterOverlay(),
        ],
      ),
    );
  }

  Widget filterOverlay() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.w)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 750.w,
        height: _isFilterShow ? 600.w : 0,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        color: Theme.of(context).primaryColor,
        child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          onLoading: _onCourseLoading,
          controller: _courseController,
          footer: myCustomFooter(),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Text(_courseList[index]?.courseTitle ?? '', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
              onPressed: () {
                _hideFilter(index);
              },
            ),
            itemCount: _courseList?.length ?? 0,
          ),
        ),
      ),
    );
  }
}
