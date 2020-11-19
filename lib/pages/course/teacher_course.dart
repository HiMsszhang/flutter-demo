import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_all_course.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/models/TeacherModel.dart';
import 'package:molan_edu/apis/teacher.dart';

class TeacherCoursePage extends StatefulWidget {
  final int id;
  const TeacherCoursePage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _TeacherCoursePageState createState() => _TeacherCoursePageState();
}

class _TeacherCoursePageState extends State<TeacherCoursePage> with UtilsMixin {
  TeacherCourseListResp _data = new TeacherCourseListResp();
  List<TeacherCourseModel> _dataList = List<TeacherCourseModel>.empty();
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

  Future<List<TeacherCourseModel>> _getList() async {
    DataResult result = await TeacherAPI.courseList(
      teacherId: widget.id,
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
    return ScaffoldWithAppbar(
      title: '全部课程',
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
          itemBuilder: (context, index) => CardAllCourse(data: _dataList[index]),
        ),
      ),
    );
  }
}
