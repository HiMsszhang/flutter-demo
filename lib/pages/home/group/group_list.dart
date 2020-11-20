import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:molan_edu/apis/group.dart';
import 'package:molan_edu/widgets/card_group.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({
    Key key,
  }) : super(key: key);

  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> with UtilsMixin {
  GroupCourseListResp _data = new GroupCourseListResp();
  List<GroupCourseModel> _dataList = List<GroupCourseModel>.empty();
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

  Future<List<GroupCourseModel>> _getList() async {
    DataResult result = await GroupAPI.groupCourseList(
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
      title: '拼团课',
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
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(bottom: 20.w),
            child: CardGroup(
              width: 690.w,
              height: 338.w,
              data: _dataList[index],
            ),
          ),
        ),
      ),
    );
  }
}
