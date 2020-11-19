import 'package:flutter/material.dart';
import 'package:molan_edu/apis/mine.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/MineCourseModel.dart';
import 'package:molan_edu/pages/course/course_detail.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MineCourseSeacher extends StatefulWidget {
  MineCourseSeacher({Key key}) : super(key: key);

  @override
  _MineCourseSeacherState createState() => _MineCourseSeacherState();
}

class _MineCourseSeacherState extends State<MineCourseSeacher> with UtilsMixin {
  String _value = '';
  MineCourseModel _courseData;
  RefreshController _listController = RefreshController(initialRefresh: true);
  int _page = 1;
  int _listRow = 10;
  List _dataList = [];

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _load();
    });
  }

  _load() async {
    await _getMineCourseData();
    _listController.requestRefresh();
    setState(() {});
  }

  void _onRefresh() async {
    _page = 1;
    _dataList = await _getMineCourseData();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    if (_courseData.lastPage == _page || _courseData.lastPage == 0) {
      _listController.loadNoData();
    } else {
      _page++;
      _dataList.addAll(await _getMineCourseData());
      _listController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  Future<List<MineCourseListModel>> _getMineCourseData() async {
    DataResult result = await MineApi.mineCourseList(
      page: _page,
      listRow: _listRow,
    );
    _courseData = result.data;
    return _courseData.data;
  }

  _onSubmitted(String value) {
    _value = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      title: '',
      actions: [
        UnconstrainedBox(
          child: Container(
            width: 623.w,
            height: 64.w,
            margin: EdgeInsets.only(right: 16.w),
            child: CommonSearch(
              onSubmitted: _onSubmitted,
              inputText: _value,
              onClear: () {
                setState(() {
                  _value = '';
                });
              },
              autofocus: true,
              leading: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Icon(
                  MyIcons.Iconsearch,
                  size: 30.w,
                  color: Color(0xFFBCBCBC),
                ),
              ),
              hintText: '搜索已购课程名称',
            ),
          ),
        ),
      ],
      body: _value == ''
          ? Container()
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
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  var item = _dataList[index];
                  return _mineCourseList(context, item);
                },
              ),
            ),
    );
  }

  Widget _mineCourseList(BuildContext context, MineCourseListModel item) {
    return _courseData?.total == 0
        ? Container()
        : Container(
            margin: EdgeInsets.only(bottom: 20.w),
            clipBehavior: Clip.hardEdge,
            decoration: Styles.normalDecoration.copyWith(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: RawMaterialButton(
              onPressed: () {
                NavigatorUtils.push(
                  context,
                  CourseDetailPage(courseId: item.courseId),
                );
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30.w, 30.w, 0, 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(item.courseTitle, style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                                  Text('【${item.typefaceTitle}.钢笔】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
                                ],
                              ),
                            ),
                            Text('${item.totalHours}课时', style: Styles.normalFont(fontSize: 26.sp)),
                            SizedBox(width: 30.w),
                          ],
                        ),
                        SizedBox(height: 17.w),
                        Text('学习时间：${item.learningTime}', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666), overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text('课程难度', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                                SizedBox(width: 10.w),
                                MiniRatingStar(rating: item.courseDifficulty.toDouble()),
                              ],
                            ),
                            Container(
                              width: 140.w,
                              height: 56.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(56.w)),
                                color: Theme.of(context).accentColor,
                              ),
                              child: Text(
                                  item.status == 1
                                      ? '未学习'
                                      : item.status == 2
                                          ? '学习中'
                                          : '已结束',
                                  style: Styles.normalFont(fontSize: 26.sp, color: Colors.white)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: 0.5, color: Color(0xFFF5F5F5))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonAvatar(
                                  size: 40.w,
                                  showSex: false,
                                  avatar: item.avatar,
                                ),
                                SizedBox(width: 15.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.teacherName, style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                                    Row(
                                      children: [
                                        ...List.generate(3, (index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 4.w),
                                            margin: EdgeInsets.only(right: 20.w, top: 4.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(36.w),
                                              color: Color(0xFFEEEEEE),
                                            ),
                                            child: Text('12345', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999, height: 1.2)),
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('已支付\n¥${item.orderPrice}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.colorRed, fontWeight: FontWeight.bold, height: 1.5), textAlign: TextAlign.right),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
