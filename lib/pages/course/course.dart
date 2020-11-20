import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/card_course.dart';
import 'package:molan_edu/widgets/no_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:molan_edu/apis/course.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/models/CourseFilterModel.dart';

/// 字体编号
int _typefaceId;

///老师性别
int _gender;

///老师性格编号
int _teacherCharacterId;

///老师资质编号
int _teacherQualificationsId;

///老师证书等级编号
int _teacherCertificateId;

///老师教龄
int _teacherTeachingYearsId;
List<Map> _filterList = [
  {'title': '选择字体', 'name': 'typeface', 'id': null},
  {'title': '老师性别', 'name': 'sex', 'id': null},
  {'title': '老师性格', 'name': 'character', 'id': null},
  {'title': '老师资质', 'name': 'intelligence', 'id': null},
  {'title': '证书等级', 'name': 'rank', 'id': null},
  {'title': '老师教龄', 'name': 'age', 'id': null},
];

class CoursePage extends StatefulWidget {
  const CoursePage({
    Key key,
  }) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with UtilsMixin, AutomaticKeepAliveClientMixin<CoursePage> {
  @override
  bool get wantKeepAlive => true;

  List<CourseCatModel> _tabList = [];
  int _selectedIndex = 0;
  CourseModelListResp _data;
  List _dataList = [];
  RefreshController _listController = RefreshController(initialRefresh: false);
  int _page = 1;
  int _listRow = 10;

  /// 课程分类编号
  int _courseCateId;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    await _getCatList();
    _listController.requestRefresh();
    setState(() {});
  }

  _getCatList() async {
    DataResult res = await CourseAPI.courseCatList();
    _tabList = res.data;
    _courseCateId = _tabList[_selectedIndex].id;
    setState(() {});
  }

  Future<List> _getList() async {
    DataResult result = await CourseAPI.courseList(
      page: _page,
      listRow: _listRow,
      courseCateId: _courseCateId,
      typefaceId: _typefaceId,
      gender: _gender,
      teacherCharacterId: _teacherCharacterId,
      teacherQualificationsId: _teacherQualificationsId,
      teacherCertificateId: _teacherCertificateId,
      teacherTeachingYearsId: _teacherTeachingYearsId,
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

  _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _courseCateId = _tabList[index].id;
      _page = 1;
      _dataList.clear();
      _listController.requestRefresh();
    });
  }

  _showFilter() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: overlayTransitionsBuilder,
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return FilterOverlay(
            onSubmitted: () {
              _listController.requestRefresh();
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: _widgetTabbar(),
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

  Widget _widgetTabbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        _tabList.length,
        (index) => InkWell(
          onTap: () {
            _onTabChanged(index);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    _tabList[index].courseCateTitle,
                    style: _selectedIndex == index ? Styles.normalFont(fontSize: 36.sp, color: Styles.colorText, fontWeight: FontWeight.bold) : Styles.normalFont(fontSize: 30.sp, color: Styles.colorInfo),
                  ),
                ),
                Positioned.fill(
                  bottom: 10.w,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: .4,
                      child: Container(
                        width: double.infinity,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: _selectedIndex == index ? Theme.of(context).accentColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterOverlay extends StatefulWidget {
  final VoidCallback onSubmitted;
  const FilterOverlay({
    Key key,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> with UtilsMixin {
  CourseFilterModel _filterModel;

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    await _getFilterList();
  }

  _getFilterList() async {
    DataResult res = await CourseAPI.courseFilterList();
    _filterModel = res.data;
    _filterList.firstWhere((element) => element['name'] == 'typeface')['model'] = _filterModel.typeface;
    _filterList.firstWhere((element) => element['name'] == 'sex')['model'] = _filterModel.gender;
    _filterList.firstWhere((element) => element['name'] == 'character')['model'] = _filterModel.teacherCharacter;
    _filterList.firstWhere((element) => element['name'] == 'intelligence')['model'] = _filterModel.teacherQualifications;
    _filterList.firstWhere((element) => element['name'] == 'rank')['model'] = _filterModel.teacherCertificate;
    _filterList.firstWhere((element) => element['name'] == 'age')['model'] = _filterModel.teacherTeachingYears;
    setState(() {});
  }

  _onFilterChanged(index, id) {
    _filterList[index]['id'] = id;
    setState(() {});
  }

  _hideFilter() {
    Navigator.pop(context);
  }

  _reset() {
    for (var item in _filterList) {
      if (item['id'] != null) item['id'] = null;
    }
    setState(() {});
    _setValue();
  }

  _submit() {
    _setValue();
    _hideFilter();
    widget.onSubmitted();
  }

  _setValue() {
    _typefaceId = _filterList.firstWhere((element) => element['name'] == 'typeface')['id'];
    _gender = _filterList.firstWhere((element) => element['name'] == 'sex')['id'];
    _teacherCharacterId = _filterList.firstWhere((element) => element['name'] == 'character')['id'];
    _teacherQualificationsId = _filterList.firstWhere((element) => element['name'] == 'intelligence')['id'];
    _teacherCertificateId = _filterList.firstWhere((element) => element['name'] == 'rank')['id'];
    _teacherTeachingYearsId = _filterList.firstWhere((element) => element['name'] == 'age')['id'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _submit();
          },
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
                        onTap: () {
                          _reset();
                        },
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
                        onTap: () {
                          _submit();
                        },
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
    var filterId = _filterList[index]['id'];
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
                Text(item['title'], style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 26.w),
                Wrap(
                  spacing: 20.w,
                  runSpacing: 14.w,
                  children: List.generate(
                    item['model'].length,
                    (i) => GestureDetector(
                      onTap: () {
                        _onFilterChanged(index, item['model'][i].id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48.w),
                          color: filterId == item['model'][i].id ? Theme.of(context).accentColor : Color(0xFFE2E2E2),
                        ),
                        child: Text(item['model'][i].title, style: Styles.normalFont(fontSize: 26.sp, color: filterId == item['model'][i].id ? Colors.white : Styles.color666666, height: 1.2)),
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
