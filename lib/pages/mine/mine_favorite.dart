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
  RefreshController _listController = RefreshController(initialRefresh: false);
  List _courseDataList = [];
  int _page = 1;
  int _listRow = 10;
  String _value = '';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    delayed(() async {
      await _load();
    });
  }

  _load() async {
    await _getTeacherCollectionList();
    _listController.requestRefresh();
    setState(() {});
  }

  void _onRefresh() async {
    _page = 1;
    _courseDataList = await _getCourseCollectionList();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    if (_courseData.lastPage == _page || _courseData.lastPage == 0) {
      _listController.loadNoData();
    } else {
      _page++;
      _courseDataList.addAll(await _getCourseCollectionList());

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
                child: CommonSearch(
                  inputText: _value,
                  onSubmitted: (value) {
                    _value = value;
                    setState(() {});
                  },
                  leading: Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: Icon(
                      MyIcons.Iconsearch,
                      size: 30.w,
                      color: Color(0xFFBCBCBC),
                    ),
                  ),
                ),
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
          _courseData?.total == 0
              ? Container(
                  padding: EdgeInsets.only(top: 300.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/mine/favorite_no_course.png'), fit: BoxFit.contain),
                  ),
                  child: Text(
                    '还未收藏任何课程哦',
                    style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.w500, color: Color(0xFFFFC9A7)),
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
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                    itemCount: _courseData?.data?.length ?? 0,
                    itemBuilder: (context, index) => CardMineCourse(
                      showTags: true,
                      data: _courseData?.data,
                      index: index,
                    ),
                  ),
                ),
          _teacherDate?.total == 0
              ? Container(
                  padding: EdgeInsets.only(top: 300.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/mine/favorite_no_teacher.png'), fit: BoxFit.contain),
                  ),
                  child: Text(
                    '还未收藏任何老师哦',
                    style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.w500, color: Color(0xFFFFC9A7)),
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
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                    itemCount: _teacherDate?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = _teacherDate?.data;
                      return CardMineTeacher(
                        data: item[index],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
