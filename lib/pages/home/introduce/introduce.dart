import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_introduce.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/IntroduceModel.dart';
import 'package:molan_edu/apis/introduce.dart';

class IntroducePage extends StatefulWidget {
  final int type;
  const IntroducePage({
    Key key,
    this.type = 1,
  }) : super(key: key);

  @override
  _IntroducePageState createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> with UtilsMixin {
  IntroduceListResp _data = new IntroduceListResp();
  List<IntroduceModel> _dataList = [];
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

  Future<List<IntroduceModel>> _getList() async {
    DataResult result = await IntroduceAPI.list(
      type: widget.type,
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
      title: widget.type == 1 ? '了解墨岚' : '如何上课',
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
            child: CardIntroduce(
              data: _dataList[index],
            ),
          ),
        ),
      ),
    );
  }
}
