import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/card_course.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/apis/course.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/utils/local_storage.dart';

class CourseSearchPage extends StatefulWidget {
  const CourseSearchPage({
    Key key,
  }) : super(key: key);

  @override
  _CourseSearchPageState createState() => _CourseSearchPageState();
}

class _CourseSearchPageState extends State<CourseSearchPage> with UtilsMixin {
  CourseModelListResp _data;
  List _dataList = [];
  RefreshController _listController = RefreshController(initialRefresh: true);
  int _page = 1;
  int _listRow = 10;
  String _value = '';
  List<CourseModel> _noResultList = [];

  ///热门搜索
  List _hotTags = [];

  ///历史记录
  List _historyList = [];

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
    setState(() {});
  }

  _load() async {
    await _getHotTags();
    await _getNoResultList();
    var list = await LocalStorage.getJSON(Config.S_HISTORY);
    print(">>>>>>>>>>>>>>>");
    print(list);
    if (list == null) {
      await LocalStorage.setJSON(Config.S_HISTORY, []);
    } else {
      _historyList = list;
    }
  }

  Future<List> _getList() async {
    DataResult result = await CourseAPI.courseList(
      page: _page,
      listRow: _listRow,
      courseTitle: _value,
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

  _onSubmitted(String value) {
    _value = value;
    _addHistory(value);
    setState(() {});
  }

  _addHistory(String value) async {
    if (!_historyList.contains(value)) {
      _historyList.add(value);
      await LocalStorage.setJSON(Config.S_HISTORY, _historyList);
    } else {
      return;
    }
  }

  _removeHistory(String title) async {
    _historyList.removeAt(_historyList.indexWhere((element) => element == title));
    await LocalStorage.setJSON(Config.S_HISTORY, _historyList);
    setState(() {});
  }

  _clearHistory() async {
    _historyList.clear();
    await LocalStorage.setJSON(Config.S_HISTORY, _historyList);
    setState(() {});
  }

  _getNoResultList() async {
    DataResult result = await CourseAPI.courseNoResult();
    _noResultList = result.data;
    setState(() {});
  }

  _getHotTags() async {
    DataResult result = await CourseAPI.hotTags();
    _hotTags = result.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          UnconstrainedBox(
            child: Container(
              width: 600.w,
              height: 64.w,
              child: CommonSearch(
                leading: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Icon(
                    MyIcons.Iconsearch,
                    size: 30.w,
                    color: Color(0xFFBCBCBC),
                  ),
                ),
                hintText: S.current.searchCourse,
                autofocus: true,
                onSubmitted: _onSubmitted,
                inputText: _value,
                onClear: () {
                  setState(() {
                    _value = '';
                  });
                },
              ),
            ),
          ),
          InkWell(
            onTap: () {
              NavigatorUtils.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 34.w),
              child: Text('取消', style: Styles.normalFont(fontSize: 28.sp)),
            ),
          ),
        ],
      ),
      body: _value == ''
          ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
              child: Column(
                children: [
                  _widgetTitle(
                    title: '搜索历史',
                    name: 'history',
                    onTap: _clearHistory,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _historyList?.length ?? 0,
                    itemBuilder: (context, index) => _widgetHistory(_historyList[index]),
                  ),
                  _widgetTitle(title: '热门搜索', name: 'hot', hasClear: false),
                  Wrap(
                    spacing: 10.w,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      _hotTags?.length ?? 0,
                      (index) => _widgetHot(_hotTags[index]['keyword']),
                    ),
                  ),
                ],
              ),
            )
          : _listCourse(),
    );
  }

  Widget _widgetTitle({String title, String name, bool hasClear = true, VoidCallback onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.w),
      child: Row(
        children: [
          Image.asset('assets/images/common/icon_search_$name.png', width: 38.w, height: 38.w, fit: BoxFit.contain),
          SizedBox(width: 18.w),
          Expanded(
            child: Text(title, style: Styles.normalFont(fontSize: 32.sp)),
          ),
          hasClear
              ? GestureDetector(
                  onTap: onTap,
                  child: Text('清空', style: Styles.normalFont(fontSize: 28.sp)),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _widgetHistory(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _onSubmitted(title);
              },
              child: Text(title ?? '', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999)),
            ),
          ),
          GestureDetector(
            onTap: () {
              _removeHistory(title);
            },
            child: Container(
              padding: EdgeInsets.all(10.w),
              child: Image.asset('assets/images/common/icon_close.png', width: 24.w, height: 24.w, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetHot(String title) {
    return GestureDetector(
      onTap: () {
        _onSubmitted(title);
      },
      child: Container(
        width: 340.w,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        margin: EdgeInsets.only(bottom: 30.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              margin: EdgeInsets.only(right: 28.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Theme.of(context).accentColor,
              ),
            ),
            Text(
              title ?? '',
              style: Styles.normalFont(fontSize: 28.sp),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget _listCourse() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: _data?.total == 0 ? false : true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      controller: _listController,
      header: myCustomHeader(),
      footer: myCustomFooter(),
      child: _data?.total == 0
          ? ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(style: Styles.normalFont(fontSize: 28.sp, height: 1.5), children: [
                      TextSpan(text: '抱歉!没有'),
                      TextSpan(text: '$_value', style: Styles.normalFont(color: Color(0xFFFF9D67))),
                      TextSpan(text: '相关课程\n'),
                      TextSpan(text: '为您推荐以下课程', style: Styles.normalFont(color: Styles.color666666)),
                    ]),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 40.w),
                  itemCount: _noResultList.length,
                  itemBuilder: (context, index) => Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: CardCourse(
                      width: 690.w,
                      height: 378.w,
                      colorType: index % 3 + 1,
                      data: _noResultList[index],
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 40.w),
              itemCount: _dataList.length,
              itemBuilder: (context, index) => Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: CardCourse(
                  width: 690.w,
                  height: 378.w,
                  colorType: index % 3 + 1,
                  data: _dataList[index],
                ),
              ),
            ),
    );
  }
}
