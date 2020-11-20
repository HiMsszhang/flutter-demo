import 'dart:async';
import 'package:flutter/material.dart';
import 'package:molan_edu/apis/group.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/apis/course.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:molan_edu/pages/course/teacher_info.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:molan_edu/widgets/custom_controls.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:molan_edu/widgets/common_tabbar.dart';
import 'package:molan_edu/widgets/recommend_list.dart';
import 'package:molan_edu/widgets/rate_list.dart';
import 'package:molan_edu/widgets/popup_pay.dart';
import 'package:molan_edu/widgets/mini_rating_star.dart';

class CourseDetailPage extends StatefulWidget {
  /// 是否是拼团
  final bool isGroup;
  final courseId;
  const CourseDetailPage({
    Key key,
    this.courseId,
    this.isGroup = false,
  }) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> with UtilsMixin, SingleTickerProviderStateMixin {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  List<String> _tabList = ['课程简介', '课程目录', '课程规划'];
  int _selectedIndex = 0;
  int _currentIndex = 0;
  bool hasLogin = false;
<<<<<<< HEAD
  bool isCollection = false;
=======
  dynamic _data;
  bool _loadFlag = false;
>>>>>>> 2c68d95022d95c33f6c167b6f790602bc581373c

  @override
  void initState() {
    super.initState();
    hasLogin = context.read<UserState>().hasLogin;
    delayed(() async {
      await _load();
      _controller = VideoPlayerController.network(_data?.currentHours['url']);
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 750 / 500,
        autoPlay: true,
        looping: true,
        customControls: CustomControls(),
      );
    });
  }

  _load() async {
    widget.isGroup ? await _getGroupCourseDetail() : await _getCourseDetail();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<CourseCataloguelistModleListResp> _getCourseCatalogueData() async {
    DataResult result = await CourseAPI.coursecataloguelist(
      courseId: widget.courseId,
      page: 1,
      listRow: 10,
    );
    return result.data;
  }

  _getCourseDetail() async {
    DataResult result = await CourseAPI.coursedetail(
      courseId: widget.courseId,
    );
    _data = result.data as CourseDetailModel;
    _loadFlag = true;
    setState(() {});
  }

  _getGroupCourseDetail() async {
    DataResult result = await GroupAPI.groupCourseDetail(
      courseId: widget.courseId,
    );
    _data = result.data as GroupCourseDetailModel;
    _loadFlag = true;
    setState(() {});
  }

  Future _getCourseCollection() async {
    DataResult result = await CourseAPI.courseCollection(
      courseId: widget.courseId,
    );
    return result.data;
  }

  String _formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  String _constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return _formatTime(hour) + ":" + _formatTime(minute) + ":" + _formatTime(second);
  }

  _showPayPopup() {
    if (!hasLogin) {
      toLoginPopup();
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => PopupPay(id: widget.courseId),
      );
    }
  }

  _onChanged(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _loadFlag
          ? Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: StickyHeaderBuilder(
                      overlapHeaders: true,
                      builder: (context, stuckAmount) {
                        stuckAmount = stuckAmount.clamp(-1.0, 0.0);
                        return AppBar(
                          brightness: Brightness.values[stuckAmount == -1 ? 1 : 0],
                          backgroundColor: Color.fromRGBO(255, 255, 255, -stuckAmount),
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 33.w,
                              color: Color.lerp(Colors.white, Colors.black, -stuckAmount),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          actions: [
                            IconButton(
                              icon: ImageIcon(
                                AssetImage('assets/images/course/icon_ear.png'),
                                size: 40.w,
                                color: Color.lerp(Colors.white, Colors.black, -stuckAmount),
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: ImageIcon(
                                AssetImage('assets/images/course/icon_${isCollection == true ? 'ear' : 'favorite'}.png'),
                                size: 40.w,
                                color: Color.lerp(Colors.white, Colors.black, -stuckAmount),
                              ),
                              onPressed: () {
                                _getCourseCollection();
                                setState(() {
                                  isCollection = !isCollection;
                                });
                              },
                            ),
                          ],
                        );
                      },
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _widgetVideo(),
                          _widgetInfo(),
                          _widgetDetail(),
                          RateList(teacherId: _data?.teacherId, courseId: widget.courseId),
                          RecommendList(
                            typefaceId: _data?.typefaceId,
                            courseCateId: _data?.courseIateId,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _widgetBottom(),
              ],
            )
          : MyLoading(),
    );
  }

  Widget _widgetVideo() {
    return Container(
      width: 750.w,
      height: 500.w,
      color: Colors.black,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 750 / 500,
            child: Chewie(controller: _chewieController),
          ),
          Positioned(
            right: 0,
            bottom: 88.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              height: 52.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(52.w)),
                color: Color.fromRGBO(246, 246, 246, 0.4),
              ),
              child: Text('本节课免费试学', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF5F5F5))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              hasLogin ? NavigatorUtils.push(context, TeacherInfoPage(id: _data?.teacherId, teacherName: _data?.teacherName)) : toLoginPopup();
            },
            child: Container(
              width: 135.w,
              height: 165.w,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: _data?.avatar ?? '',
                    placeholder: (context, url) => Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 36.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color.fromRGBO(255, 255, 255, .54),
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text("${_data?.totalHours ?? 0}课时", style: Styles.normalFont(fontSize: 24.sp, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_data?.courseTitle ?? '', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
                    SizedBox(width: 14.w),
                    Text('【${_data?.typefaceTitle ?? ''}.${_data?.courseCateTitle ?? ''}】', style: Styles.normalFont(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20.w),
                Text(
                  '${widget.isGroup ? "开课" : "学习"}时间：${widget.isGroup ? _data?.openingTime : _data?.learningTime} 11:00-12:00',
                  style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 14.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('课程难度', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    SizedBox(width: 10.w),
                    MiniRatingStar(rating: _data?.courseDifficulty?.toDouble()),
                    InkWell(
                      onTap: () {
                        courseInfoPopup(context, _data);
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        margin: EdgeInsets.all(10.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.w),
                          color: Color(0xFF87B4FF),
                        ),
                        child: Text('?', style: TextStyle(fontSize: 24.sp, color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34.w),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Text('日更${_data?.dailyUpdate ?? ''}课时', style: Styles.normalFont(fontSize: 22.sp, color: Colors.white, height: 1.2)),
                    ),
                  ],
                ),
                SizedBox(height: 10.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('讲师：${_data?.teacherName ?? ''}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Image.asset('assets/images/common/icon_learn.png', width: 26.w, height: 20.w),
                        SizedBox(width: 10.w),
                        Text('学习人数：${formatNum(_data?.learnNum)}人', style: Styles.normalFont(fontSize: 24.sp, color: Styles.colorBlue)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetDetail() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 30.w).copyWith(bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 690.w,
              height: 93.w,
              margin: EdgeInsets.only(bottom: 30.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(163, 163, 163, 0.2),
                    blurRadius: 30.w,
                  )
                ],
              ),
              child: CommonTabbar(
                itemList: _tabList,
                isCenter: true,
                onChanged: _onChanged,
              ),
            ),
            _selectedIndex == 0
                ? _widgetSummary()
                : _selectedIndex == 1
                    ? _widgetIndex()
                    : _widgetPlan(),
          ],
        ),
      ),
    );
  }

  /// 课程简介
  Widget _widgetSummary() {
    return Container(
      width: 690.w,
      height: 460.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        imageUrl: _data?.courseDesc ?? '',
        placeholder: (context, url) => Image.asset('assets/images/placeholder.png'),
      ),
    );
  }

  /// 课程目录
  Widget _widgetIndex() {
    return FutureBuilder(
      future: _getCourseCatalogueData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          CourseCataloguelistModleListResp item = snapshot.data;
          return Container(
            width: 690.w,
            height: 460.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(163, 163, 163, 0.2),
                  blurRadius: 30.w,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25.w, 16.w, 25.w, 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('${item.data[_currentIndex].courseArrangement} I ${item.data[_currentIndex].courseCatalogueTitle}', style: Styles.normalFont(fontSize: 30.sp)),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 174.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(46.w),
                            color: Theme.of(context).accentColor,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('正在播放', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white, height: 1.2)),
                              Icon(
                                Icons.play_arrow_rounded,
                                size: 40.w,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: item.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(25.w, 16.w, 63.w, 16.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(style: Styles.normalFont(fontSize: 28.sp), children: [
                                  TextSpan(text: '${item.data[index].courseArrangement}'),
                                  TextSpan(text: '  I  ${item.data[index].courseCatalogueTitle}', style: Styles.normalFont(color: Color(0xFF777777))),
                                ]),
                              ),
                            ),
                            Text('${_constructTime(item.data[index].duration)}', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            alignment: Alignment.topCenter,
            width: 100.w,
            height: 100.w,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /// 规划
  Widget _widgetPlan() {
    return Container(
      width: 690.w,
      height: 460.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        imageUrl: _data?.curriculumPlanning ?? '',
        placeholder: (context, url) => Image.asset('assets/images/placeholder.png'),
      ),
    );
  }

  Widget _widgetBottom() {
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        padding: EdgeInsets.only(left: 58.w, right: 32.w),
        height: 130.w,
        decoration: Styles.normalDecoration.copyWith(
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            /// 是否拼团
            widget.isGroup
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('早鸟拼团价', style: Styles.normalFont(fontSize: 26.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 19.w),
                        RichText(
                          text: TextSpan(style: Styles.normalFont(fontSize: 36.sp, color: Styles.color999999), children: [
                            TextSpan(text: '￥${_data?.marketPrice}', style: Styles.normalFont(fontWeight: FontWeight.bold, color: Styles.colorRed)),
                            TextSpan(text: '/期  '),
                            TextSpan(text: '￥${_data?.coursePrice}', style: TextStyle(fontSize: 28.sp, color: Styles.color999999, decoration: TextDecoration.lineThrough)),
                          ]),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: RichText(
                      text: TextSpan(style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold, color: Styles.color999999), children: [
                        TextSpan(text: '￥${_data?.coursePrice ?? ''}', style: Styles.normalFont(color: Styles.colorRed)),
                        TextSpan(text: '/期'),
                      ]),
                    ),
                  ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75.w),
                color: Theme.of(context).accentColor,
              ),
              child: RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.w),
                onPressed: () {
                  _showPayPopup();
                },
                child: Text('立即${widget.isGroup ? '参团' : '购买'}', style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
