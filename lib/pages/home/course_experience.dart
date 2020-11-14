import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:molan_edu/widgets/card_experience.dart';
import 'package:molan_edu/widgets/no_data.dart';
import 'package:molan_edu/apis/group.dart';

class CourseExperiencePage extends StatefulWidget {
  const CourseExperiencePage({
    Key key,
  }) : super(key: key);

  @override
  _CourseExperiencePageState createState() => _CourseExperiencePageState();
}

class _CourseExperiencePageState extends State<CourseExperiencePage> with UtilsMixin {
  ExperienceModelListResp _data;
  List _dataList = [];
  RefreshController _listController = RefreshController(initialRefresh: false);
  int _page = 1;

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

  Future<List> _getList() async {
    DataResult result = await GroupAPI.getExperienceList(
      page: _page,
      listRow: 10,
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
    return ScaffoldWithAppbar(
      title: '体验课',
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
          padding: EdgeInsets.symmetric(vertical: 40.w),
          itemCount: _data?.total == 0 ? 1 : _dataList?.length,
          itemBuilder: (context, index) => _dataList.length > 0
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10.w),
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: CardExperience(
                    width: 690.w,
                    height: 378.w,
                    data: _dataList[index],
                  ),
                )
              : Container(
                  width: 690.w,
                  height: 800.w,
                  child: NoData(),
                ),
        ),
      ),
    );
  }
}
