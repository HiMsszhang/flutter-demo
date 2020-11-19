import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_all_course.dart';
import 'package:molan_edu/widgets/card_mine_teacher.dart';
import 'package:molan_edu/widgets/card_share.dart';
import 'package:molan_edu/widgets/rate_list.dart';
import 'package:molan_edu/apis/teacher.dart';
import 'package:molan_edu/models/TeacherModel.dart';
import 'package:molan_edu/pages/course/teacher_course.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TeacherInfoPage extends StatefulWidget {
  final int id;
  final String teacherName;
  const TeacherInfoPage({
    Key key,
    this.id,
    this.teacherName = "",
  }) : super(key: key);

  @override
  _TeacherInfoPageState createState() => _TeacherInfoPageState();
}

class _TeacherInfoPageState extends State<TeacherInfoPage> with UtilsMixin {
  TeacherInfoModel _data;
  bool _loadFlag = false;

  TeacherShareListResp _resp = new TeacherShareListResp();
  List<TeacherShareModel> _dataList;
  RefreshController _listController = RefreshController(initialRefresh: false);
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
    await _getInfo();
    _dataList = await _getList();
  }

  _getInfo() async {
    DataResult res = await TeacherAPI.info(teacherId: widget.id);
    _data = res.data;
    _loadFlag = true;
    setState(() {});
  }

  _toAllCourse() {
    NavigatorUtils.push(context, TeacherCoursePage(id: _data?.teacher?.id));
  }

  Future<List<TeacherShareModel>> _getList() async {
    DataResult result = await TeacherAPI.shareList(
      teacherId: widget.id,
      page: _page,
      listRow: _listRow,
    );
    _resp = result.data;
    return _resp.data;
  }

  void _onLoading() async {
    if (_resp.lastPage == _page || _resp.lastPage == 0) {
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 525.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(400.w, 34.w)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [Color(0xFFFFCAAD), Color(0xFFFFA7A3)],
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                brightness: Brightness.dark,
                title: Text(
                  '${widget.teacherName}的主页',
                  style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 33.w,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: _loadFlag
                    ? SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        onLoading: _onLoading,
                        controller: _listController,
                        footer: myCustomFooter(),
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 40.w),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Column(
                                children: [
                                  CardMineTeacher(showTags: true, data: _data?.teacher),
                                  Container(
                                    width: 690.w,
                                    height: 109.w,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: Styles.normalDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(16.w),
                                    ),
                                    margin: EdgeInsets.only(bottom: 14.w),
                                    child: RawMaterialButton(
                                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                                      onPressed: () {
                                        _toAllCourse();
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset('assets/images/course/icon_course.png', width: 30.w, height: 30.w),
                                          SizedBox(width: 18.w),
                                          Expanded(
                                            child: Text('全部课程.${_data?.totalCourseNum}', style: Styles.normalFont(fontSize: 32.sp)),
                                          ),
                                          Text('查看更多', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999)),
                                          SizedBox(width: 10.w),
                                          Icon(Icons.arrow_forward_ios, size: 23.w, color: Styles.color999999),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    _data?.course?.length ?? 0,
                                    (index) => CardAllCourse(
                                      data: _data?.course[index],
                                    ),
                                  ),
                                  RateList(),
                                  SizedBox(height: 20.w),
                                  Container(
                                    width: 690.w,
                                    height: 109.w,
                                    clipBehavior: Clip.hardEdge,
                                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                                    decoration: Styles.normalDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(16.w),
                                    ),
                                    child: Row(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/images/common/icon_share.png'),
                                          size: 30.w,
                                          color: Theme.of(context).accentColor,
                                        ),
                                        SizedBox(width: 18.w),
                                        Expanded(
                                          child: Text('${_data?.teacher?.teacherName}老师的分享', style: Styles.normalFont(fontSize: 32.sp)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14.w),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _dataList?.length ?? 0,
                              itemBuilder: (context, index) => CardShare(),
                            ),
                          ],
                        ),
                      )
                    : MyLoading(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
