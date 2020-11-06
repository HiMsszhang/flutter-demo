import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/common_tabbar.dart';
import 'package:molan_edu/widgets/card_course.dart';
import 'package:molan_edu/widgets/no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:molan_edu/apis/course.dart';
import 'package:molan_edu/models/CourseModel.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({
    Key key,
  }) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with UtilsMixin {
  List<String> _tabList = ['钢笔', '毛笔'];
  int _selectedIndex = 0;
  CourseModelListResp _data;
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
    DataResult result = await CourseAPI.courseList(
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

  _onChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _showFilter() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: overlayTransitionsBuilder,
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FilterOverlay();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: CommonTabbar(
              itemList: _tabList,
              onChanged: _onChanged,
            ),
          ),
          UnconstrainedBox(
            child: Container(
              width: 393.w,
              height: 64.w,
              child: CommonSearch(
                readOnly: true,
                onTap: () {
                  NavigatorUtils.pushNamed(context, '/course.search');
                },
                leading: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 0),
                  child: Icon(
                    MyIcons.Iconsearch,
                    size: 30.w,
                    color: Color(0xFFBCBCBC),
                  ),
                ),
                hintText: S.current.searchCourse,
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset(
                'assets/images/course/icon_filter.png',
                width: 30.w,
                height: 30.w,
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              _showFilter();
            },
          ),
        ],
      ),
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
                  child: CardCourse(
                    width: 690.w,
                    height: 378.w,
                    colorType: index % 3 + 1,
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

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({
    Key key,
  }) : super(key: key);

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> with UtilsMixin {
  List<Map> _filterList = [
    {'title': '选择字体', 'name': 'typeface'},
    {'title': '老师性别', 'name': 'sex'},
    {'title': '老师性格', 'name': 'character'},
    {'title': '老师资质', 'name': 'intelligence'},
    {'title': '证书等级', 'name': 'rank'},
    {'title': '老师教龄', 'name': 'age'},
  ];
  List<int> _filterIndexList = [null, null, null, null, null, null];

  @override
  void initState() {
    super.initState();
  }

  _onFilterChanged(index, i) {
    var item = _filterIndexList[index];
    item = i;
    _filterIndexList[index] = item;
    setState(() {});
  }

  _hideFilter() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _hideFilter,
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(),
            elevation: 0,
          ),
        ),
        Expanded(
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 20.w),
                    itemBuilder: (context, index) => _widgetFilterItem(_filterList[index], index),
                    itemCount: _filterList.length,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _hideFilter,
                        child: Container(
                          alignment: Alignment.center,
                          height: 100.w,
                          color: Color(0xFFFFC4A3),
                          child: Text('重 置', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _hideFilter,
                        child: Container(
                          alignment: Alignment.center,
                          height: 100.w,
                          color: Color(0xFFFFA573),
                          child: Text('确 认', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
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
    );
  }

  Widget _widgetFilterItem(item, index) {
    var filterIndex = _filterIndexList[index];
    return Padding(
      padding: EdgeInsets.all(30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/course/icon_filter_${item['name']}.png', width: 34.w, height: 34.w),
          SizedBox(width: 17.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], style: Styles.specialFont(fontSize: 32.sp)),
                SizedBox(height: 26.w),
                Wrap(
                  spacing: 20.w,
                  runSpacing: 14.w,
                  children: List.generate(
                    8,
                    (i) => GestureDetector(
                      onTap: () {
                        _onFilterChanged(index, i);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48.w),
                          color: filterIndex == i ? Theme.of(context).accentColor : Color(0xFFE2E2E2),
                        ),
                        child: Text('活泼', style: Styles.normalFont(fontSize: 26.sp, color: filterIndex == i ? Colors.white : Styles.color666666, height: 1.2)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
