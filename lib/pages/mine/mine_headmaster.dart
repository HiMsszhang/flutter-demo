import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molan_edu/apis/mine.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/MineHeadMasterModel.dart';
import 'package:molan_edu/pages/chat/chat_person.dart';
import 'package:molan_edu/pages/course/teacher_info.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/custom_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:molan_edu/widgets/no_data.dart';

class MineHeadMasterPage extends StatefulWidget {
  const MineHeadMasterPage({
    Key key,
  }) : super(key: key);

  @override
  _MineHeadMasterPageState createState() => _MineHeadMasterPageState();
}

class _MineHeadMasterPageState extends State<MineHeadMasterPage> with UtilsMixin {
  TextEditingController _contentController = TextEditingController();
  MineHeadMasterModel _data;
  RefreshController _listController = RefreshController(initialRefresh: false);
  int _page = 1;
  int _listRow = 10;
  List _dataList = [];
  int _courseId;
  int _classTeacherId;
  double _evaluate;
  String _content;

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

  void _onRefresh() async {
    _page = 1;
    _dataList = await _getMineHeadMasterData();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    if (_data.lastPage == _page || _data.lastPage == 0) {
      _listController.loadNoData();
    } else {
      _page++;
      _dataList.addAll(await _getMineHeadMasterData());
      _listController.loadComplete();
    }
    if (mounted) setState(() {});
  }

  Future _getMineHeadMasterData() async {
    DataResult result = await MineApi.mineHeadMasterList(
      page: _page,
      listRow: _listRow,
    );
    _data = result.data;
  }

  Future _getmineHeadTeacherEvaluate(item) async {
    DataResult result = await MineApi.mineHeadTeacherEvaluate(
      courseId: _courseId,
      classTeacherId: _classTeacherId,
      evaluate: _evaluate,
      content: _content,
    );
    return result;
  }

  _submitComments(item) async {
    setState(() {
      _classTeacherId = item.classTeacherId;
      _content = _contentController.text;
      _courseId = item.courseId;
    });

    await _getmineHeadTeacherEvaluate(item);

    NavigatorUtils.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      title: '我的班主任',
      body: _data?.total == 0
          ? NoData(text: '还没有任何班主任哦', backgroundColor: Color(0xFFFFF7F3), url: "assets/images/mine/favorite_no_teacher.png")
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 34.w),
                    itemCount: _data?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var item = _data?.data[index];
                      return _widgetItem(item);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _widgetItem(item) {
    return Container(
      width: 690.w,
      height: 265.w,
      margin: EdgeInsets.only(bottom: 14.w),
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      padding: EdgeInsets.all(30.w),
      child: Row(
        children: [
          Container(
            width: 167.w,
            height: 205.w,
            margin: EdgeInsets.only(right: 24.w),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: InkWell(
              onTap: () {
                NavigatorUtils.push(context, TeacherInfoPage());
              },
              child: Stack(
                children: [
                  Image.network(item.avatar, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0),
                            Color.fromRGBO(0, 0, 0, 1),
                          ],
                        ),
                      ),
                      child: Text(
                        item.classTeacherName,
                        style: Styles.normalFont(fontSize: 24.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(item.courseTitle, style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold, height: 1.2)),
                    Text('【${item.typefaceTitle}】', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                  ],
                ),
                SizedBox(height: 22.w),
                Row(
                  children: [
                    Text('微信号：${item.wechat}', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                    SizedBox(width: 36.w),
                    InkWell(
                      onTap: () {
                        ClipboardData data = new ClipboardData(text: item.wechat);
                        Clipboard.setData(data);
                        showToast('已复制到剪切板');
                      },
                      child: Container(
                        width: 78.w,
                        height: 34.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.w), color: Theme.of(context).accentColor),
                        child: Text('复制', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigatorUtils.push(
                              context,
                              ChatPersonPage(
                                id: item.classTeacherId,
                                name: item.classTeacherName,
                              ));
                        },
                        child: Container(
                          width: 196.w,
                          height: 55.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Text('APP内对话', style: Styles.normalFont(fontSize: 28.sp, color: Colors.white)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _popupRate(context, item);
                        },
                        child: Container(
                          width: 196.w,
                          height: 55.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            border: Border.all(width: 1, color: Styles.colorBlue),
                          ),
                          child: Text('修改评价', style: Styles.normalFont(fontSize: 28.sp, color: Styles.colorBlue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 评价弹窗
  _popupRate(BuildContext context, item) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.w).copyWith(bottom: 50.w + MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('评价班主任', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 22.w),
            Text('滑动星星给出星级评价！', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
            SizedBox(height: 32.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar(
                  icon: Image.asset('assets/images/common/icon_star_border.png', width: 43.w, height: 43.w),
                  size: 43.w,
                  spacing: 7.w,
                  color: Theme.of(context).accentColor,
                  onRatingCallback: (value, i) {
                    setState(() {
                      _evaluate = value;
                    });
                  },
                ),
                SizedBox(width: 7.w),
                Text('很赞！', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor, height: 1.2)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 64.w, bottom: 39.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(height: 1, color: Color(0xFFF5F5F5)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    color: Colors.white,
                    child: Text('我想对班主任说', style: Styles.normalFont(fontSize: 28.sp)),
                  ),
                  Expanded(
                    child: Container(height: 1, color: Color(0xFFF5F5F5)),
                  ),
                ],
              ),
            ),
            Container(
              width: 690.w,
              height: 153.w,
              color: Color(0xFFF5F5F5),
              padding: EdgeInsets.all(10.w),
              child: TextField(
                controller: _contentController,
                maxLength: 30,
                maxLines: 5,
                style: Styles.normalFont(fontSize: 26.sp),
                decoration: InputDecoration(
                  hintText: S.current.inputPlaceholder,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                ),
              ),
            ),
            SizedBox(height: 40.w),
            InkWell(
              onTap: () {
                _submitComments(item);
              },
              child: Container(
                width: 690.w,
                height: 90.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.w),
                  color: Theme.of(context).accentColor,
                ),
                child: Text('提 交', style: Styles.normalFont(fontSize: 30.sp, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
