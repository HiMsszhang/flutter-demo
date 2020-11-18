import 'package:flutter/material.dart';
import 'package:molan_edu/apis/mine.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/CourseCollectionModel.dart';
import 'package:molan_edu/models/teacherCollectionModel.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_mine_course.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:molan_edu/widgets/card_mine_teacher.dart';
import 'package:molan_edu/widgets/common_search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineFavoritePage extends StatefulWidget {
  const MineFavoritePage({
    Key key,
  }) : super(key: key);

  @override
  _MineFavoritePageState createState() => _MineFavoritePageState();
}

class _MineFavoritePageState extends State<MineFavoritePage> with UtilsMixin {
  Map<int, Widget> _children = {
    0: Text('课程', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
    1: Text('老师', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
  };
  int _selectedIndex = 0;
  PageController _pageController;
  bool _showSearch = false;
  CourseCollectionModel _courseData;
  TeacherCollectionModel _teacherDate;
  var _futureBuilderFuture;
  RefreshController _listController = RefreshController(initialRefresh: false);
  List _dataList = [];
  int _page = 1;
  int _listRow = 10;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _futureBuilderFuture = _getCourseCollectionList();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    await _getCourseCollectionList();
    _listController.requestRefresh();
    setState(() {});
  }

  void _onRefresh() async {
    _page = 1;
    _dataList = await _getCourseCollectionList();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    if (_courseData.lastPage == _page) {
      _listController.loadNoData();
    } else {
      _page++;
      _dataList.addAll(await _getCourseCollectionList());
      _listController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  Future _getCourseCollectionList() async {
    DataResult result = await MineApi.courseCollectionlist(
      page: _page,
      listRow: _listRow,
    );
    _courseData = result.data;
    return _courseData.data;
  }

  Future _getTeacherCollectionList() async {
    DataResult result = await MineApi.teacherCollectionList(
      page: _page,
      listRow: _listRow,
    );
    _teacherDate = result.data;
    return _teacherDate.data;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onSegmentChosen(value) {
    _selectedIndex = value;
    _pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    setState(() {});
  }

  _onPageChanged(value) {
    _selectedIndex = value;
    _showSearch = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      title: '',
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 416.w,
                  margin: EdgeInsets.only(right: 67.w),
                  child: MaterialSegmentedControl(
                    onSegmentChosen: _onSegmentChosen,
                    unselectedColor: Theme.of(context).primaryColor,
                    selectedColor: Theme.of(context).accentColor,
                    selectionIndex: _selectedIndex,
                    borderColor: Theme.of(context).accentColor,
                    children: _children,
                    verticalOffset: 8.w,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    MyIcons.Iconsearch,
                    size: 30.w,
                    color: Color(0xFFBCBCBC),
                  ),
                  onPressed: () {
                    setState(() {
                      _showSearch = true;
                    });
                  },
                ),
              ],
            ),
            UnconstrainedBox(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: 30.w),
                width: _showSearch ? 609.w : 0,
                height: 64.w,
                child: CommonSearch(),
              ),
            ),
          ],
        ),
      ],
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          FutureBuilder(
            future: _futureBuilderFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  controller: _listController,
                  header: myCustomHeader(),
                  footer: myCustomFooter(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                    itemCount: _courseData.data.length,
                    itemBuilder: (context, index) => CardMineCourse(
                      showTags: true,
                      data: _courseData.data,
                      index: index,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder(
            future: _getTeacherCollectionList(),
            builder: (context, snapshot) {
              var item = _teacherDate.data;
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                controller: _listController,
                header: myCustomHeader(),
                footer: myCustomFooter(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return CardMineTeacher(
                      data: item,
                      index: index,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
