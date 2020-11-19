import 'package:flutter/material.dart';
import 'package:molan_edu/apis/timeTable.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_timetable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/TimeTableModel.dart';

class TimetableListPage extends StatefulWidget {
  final int id;
  final String title;
  //课程学习模式 1--普通 2--VIP
  final int courseModelId;
  const TimetableListPage({
    Key key,
    this.id,
    this.title = '',
    this.courseModelId,
  }) : super(key: key);

  @override
  _TimetableListPageState createState() => _TimetableListPageState();
}

class _TimetableListPageState extends State<TimetableListPage> with UtilsMixin {
  TimeTableMenuListResp _data = new TimeTableMenuListResp();
  List<TimeTableMenuModel> _dataList = List<TimeTableMenuModel>.empty();
  RefreshController _listController = RefreshController(initialRefresh: true);
  int _page = 1;
  int _listRow = 10;
  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    setState(() {});
  }

  Future<List<TimeTableMenuModel>> _getList() async {
    DataResult result = await TimeTableAPI.menuList(
      page: _page,
      listRow: _listRow,
      courseId: widget.id,
    );
    _data = result.data;
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

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: widget.title ?? '',
      backgroundColor: Theme.of(context).primaryColor,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        controller: _listController,
        header: myCustomHeader(),
        footer: myCustomFooter(),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
          itemCount: _dataList.length ?? 0,
          itemBuilder: (context, index) => CardTimetable(
            data: _dataList[index],
            courseModelId: widget.courseModelId,
          ),
        ),
      ),
    );
  }
}
