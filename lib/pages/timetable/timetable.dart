import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_leaning.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/TimeTableModel.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/apis/timeTable.dart';

class TimetablePage extends StatefulWidget {
  final jumpToPage;
  const TimetablePage({
    Key key,
    this.jumpToPage,
  }) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> with UtilsMixin, AutomaticKeepAliveClientMixin<TimetablePage> {
  @override
  bool get wantKeepAlive => true;

  TimeTableListResp _data;
  List<TimeTableModel> _dataList = new List<TimeTableModel>.empty();
  RefreshController _listController = RefreshController(initialRefresh: false);
  int _page = 1;
  int _listRow = 10;
  bool hasLogin = false;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    hasLogin = context.read<UserState>().hasLogin;
    if (hasLogin) _listController.requestRefresh();
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
    super.build(context);
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
                child: !hasLogin && _data?.total != null
                    ? Container(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Styles.normalFont(fontSize: 30.sp, color: Colors.white, height: 1.5),
                            children: [
                              TextSpan(text: '暂无课程表\n请'),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    NavigatorUtils.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    '登录',
                                    style: Styles.normalFont(fontSize: 30.sp, color: Theme.of(context).accentColor, decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                              TextSpan(text: '后查看'),
                            ],
                          ),
                        ),
                      )
                    : SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        controller: _listController,
                        header: myCustomHeader(),
                        footer: myCustomFooter(),
                        child: ListView(
                          children: [
                            _data?.total == 0
                                ? Container(
                                    alignment: Alignment.center,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: Styles.normalFont(fontSize: 30.sp, color: Colors.white, height: 1.5),
                                        children: [
                                          TextSpan(text: '暂无课程表\n先去课程广场'),
                                          WidgetSpan(
                                            child: GestureDetector(
                                              onTap: () {
                                                widget.jumpToPage(1);
                                              },
                                              child: Text(
                                                '看看吧',
                                                style: Styles.normalFont(fontSize: 30.sp, color: Theme.of(context).accentColor, decoration: TextDecoration.underline),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
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
