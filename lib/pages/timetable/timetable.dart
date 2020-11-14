import 'package:flutter/material.dart';
import 'package:molan_edu/apis/timeTable.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_leaning.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/TimeTableModel.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({
    Key key,
  }) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> with UtilsMixin {
  TimeTableListResp _data;
  List<TimeTableModel> _dataList = [];
  RefreshController _listController = RefreshController(initialRefresh: false);
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
    _listController.requestRefresh();
    setState(() {});
  }

  Future<List<TimeTableModel>> _getList() async {
    DataResult result = await TimeTableAPI.list(
      page: _page,
      listRow: _listRow,
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
    if (_data.lastPage == _page) {
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [Color(0xFFFFC4A3), Color(0xFFFFABA4)],
                transform: GradientRotation(-10),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text(
                  '课程表',
                  style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  controller: _listController,
                  header: myCustomHeader(),
                  footer: myCustomFooter(),
                  child: ListView(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                        itemCount: _dataList.length,
                        itemBuilder: (context, index) => CardLeaning(data: _dataList[index]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
