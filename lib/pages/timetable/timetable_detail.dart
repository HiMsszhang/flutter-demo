import 'package:flutter/material.dart';
import 'package:molan_edu/apis/timeTable.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/TimeTableModel.dart';
import 'package:molan_edu/pages/other/fullscreen_video.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/popup_rate.dart';

class TimetableDetailPage extends StatefulWidget {
  final int id;
  final String title;
  const TimetableDetailPage({
    Key key,
    this.id,
    this.title = '',
  }) : super(key: key);

  @override
  _TimetableDetailPageState createState() => _TimetableDetailPageState();
}

class _TimetableDetailPageState extends State<TimetableDetailPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<TimeTableMenuDetailModel> _getDetail() async {
    DataResult result = await TimeTableAPI.menuDetail(
      courseCatalogueId: widget.id,
    );
    return result.data;
  }

  _toVideo(TimeTableMenuDetailModel data) {
    NavigatorUtils.push(context, FullscreenVideoPage(url: data.url, title: data.courseCatalogueTitle));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: widget.title,
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: _getDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            TimeTableMenuDetailModel data = snapshot.data;
            return ListView(
              padding: EdgeInsets.only(bottom: 40.w),
              children: [
                Container(
                  width: 750.w,
                  height: 378.w,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: data.image,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/demo.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 23.w,
                        left: 0,
                        child: Container(
                          height: 55.w,
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(55.w)),
                            color: Color.fromRGBO(255, 255, 255, 0.22),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            data.courseArrangement,
                            style: Styles.normalFont(fontSize: 26.sp, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30.w),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 3.w, color: Color(0xFFF5F5F5))),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(data.courseCatalogueTitle, style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                      SizedBox(width: 16.w),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.w),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF5F5F5))),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ImageIcon(
                        AssetImage('assets/images/timetable/icon_reward.png'),
                        size: 50.w,
                        color: data.completionStatus == 3 ? Theme.of(context).accentColor : Color(0xFFD7D7D7),
                      ),
                      SizedBox(width: 40.w),
                      ...List.generate(
                        data.courseModelId == 1 ? 2 : 3,
                        (index) => Container(
                          margin: EdgeInsets.only(right: 30.w),
                          child: ImageIcon(
                            AssetImage('assets/images/timetable/icon_learn.png'),
                            size: 41.w,
                            color: data.completionStatus > index ? Theme.of(context).accentColor : Color(0xFFD7D7D7),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: data.completionStatus == 3 ? Theme.of(context).accentColor : Color(0xFFD7D7D7),
                              ),
                              child: Icon(
                                Icons.check,
                                size: 30.w,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text('${data.completionStatus == 3 ? "已" : "未"}完成', style: Styles.normalFont(fontSize: 28.sp, color: data.completionStatus == 3 ? Theme.of(context).accentColor : Styles.color999999, height: 1.2)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30.w),
                  child: Text('学习流程', style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold)),
                ),
                _widgetProgress(
                  title: '视频学习',
                  image: 'assets/images/timetable/bg_learn_video.png',
                  done: data.completionStatus == 1,
                  onTap: () {
                    if (data.completionStatus == 0) _toVideo(data);
                  },
                ),
                _widgetProgress(
                  title: '提交作业',
                  image: 'assets/images/timetable/bg_learn_homework.png',
                  done: data.completionStatus == 2,
                ),
                _widgetProgress(
                  title: '评价本课',
                  image: 'assets/images/timetable/bg_learn_rate.png',
                  done: data.completionStatus == 3,
                  last: true,
                  onTap: () {
                    _popupRate(context);
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _widgetProgress({
    String title = '',
    bool done = false,
    String image = '',
    bool last = false,
    VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.w),
                  color: done ? Theme.of(context).accentColor : Color(0xFFD7D7D7),
                ),
                child: Icon(
                  Icons.check,
                  size: 30.w,
                  color: Colors.white,
                ),
              ),
              Container(
                width: last ? 0 : 4.w,
                height: 219.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      done ? Theme.of(context).accentColor : Color(0xFFDDDDDD),
                      Color(0xFFDDDDDD),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 19.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${done ? '已' : '未'}完成', style: Styles.normalFont(fontSize: 28.sp, color: done ? Theme.of(context).accentColor : Styles.color999999, height: 1.2)),
                SizedBox(height: 23.w),
                GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    width: 630.w,
                    height: 167.w,
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.w),
                      image: DecorationImage(
                        image: AssetImage(image),
                        colorFilter: ColorFilter.mode(Color(0xFFEFEFEF), done ? BlendMode.dst : BlendMode.srcIn),
                      ),
                    ),
                    child: Text(title, style: Styles.normalFont(fontSize: 28.sp, color: done ? Colors.white : Styles.color999999)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _popupRate(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PopupRate();
      },
    );
  }
}
