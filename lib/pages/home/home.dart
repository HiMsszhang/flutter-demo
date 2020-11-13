import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:molan_edu/widgets/card_experience.dart';
import 'package:molan_edu/widgets/card_new_course.dart';
import 'package:molan_edu/widgets/my_pagination.dart';
import 'package:molan_edu/apis/group.dart';
import 'package:molan_edu/apis/course.dart';
import 'package:molan_edu/models/CourseModel.dart';
import 'package:molan_edu/models/GroupModel.dart';
import 'package:molan_edu/models/AdModel.dart';

class NavItem {
  String title;
  String image;

  NavItem({
    this.title,
    this.image,
  });
}

class HomePage extends StatefulWidget {
  final jumpToPage;

  const HomePage({Key key, this.jumpToPage}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with UtilsMixin {
  List<NavItem> _navList = [
    NavItem(title: S.current.homeNavWriting, image: 'writing'),
    NavItem(title: S.current.homeNavCourse, image: 'course'),
    NavItem(title: S.current.homeNavGroup, image: 'group'),
    NavItem(title: S.current.homeNavInvite, image: 'invite'),
  ];
  List<Map> _promiseList = [
    {'title': '退款承诺', 'icon': 'repay', 'info': '对课程不满意，对效果不满意，在课程有效期内可以随时提出提款要求。'},
    {'title': '服务承诺', 'icon': 'service', 'info': '根据孩子的特点与进度匹配专业的班主任提供五星服务。'},
    {'title': '师资承诺', 'icon': 'teacher', 'info': '墨岚教育讲师团队拥有丰富的书法教学经验经过严格筛选 保证每位讲师的授课质量'},
    {'title': '安全承诺', 'icon': 'safe', 'info': '拥有银行资金储备保障的在线教育平台保障用户课时费安全'},
  ];
  List<ExperienceModel> _experienceList = [];
  List<CourseModel> _newCourseList = [];

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getExperienceList();
      await _getNewCourseList();
    });
    setState(() {});
  }

  _onNavItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        NavigatorUtils.pushNamed(context, '/group');
        break;
      case 1:
        widget.jumpToPage(1);
        break;
      case 2:
        NavigatorUtils.pushNamed(context, '/group');
        break;
      case 3:
        NavigatorUtils.pushNamed(context, '/invite');
        break;
    }
  }

  Future<List<AdModel>> _getAdList() async {
    DataResult res = await CommonAPI.adList(advertCateId: 1);
    return res.data;
  }

  _getExperienceList() async {
    DataResult res = await GroupAPI.getExperienceList(page: 1, listRow: 4);
    _experienceList = res.data.data;
    setState(() {});
  }

  _getNewCourseList() async {
    DataResult res = await CourseAPI.newCourseList();
    _newCourseList = res.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 49.w),
                child: Image.asset(
                  "assets/images/logo_text.png",
                  width: 123.w,
                  height: 47.w,
                  fit: BoxFit.contain,
                ),
              ),
              UnconstrainedBox(
                child: Container(
                  width: 522.w,
                  height: 64.w,
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(64.w),
                    border: Border.all(width: 0.5, color: Colors.white),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 19.w),
                      Icon(
                        MyIcons.Iconsearch,
                        size: 30.w,
                        color: Color(0xFFBBBBBB),
                      ),
                      SizedBox(width: 19.w),
                      Text('搜索课程名称', style: Styles.normalFont(fontSize: 28.sp, color: Color(0xFFBBBBBB))),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 30.w),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 40.w),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    _widgetBanner(),
                    SizedBox(height: 124.w),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 30.w,
                  child: _widgetNav(),
                ),
              ],
            ),
            _widgetKnow(),
            _widgetTitle(title: S.current.experienceCourse, color: Color(0xFFFFE6B0), showMore: true),
            _widgetExperience(),
            _widgetTitle(title: S.current.homeNewCourse, color: Color(0xFFCBB0FF), showMore: false),
            _widgetNewCourse(),
            _widgetTitle(title: S.current.wePromise, color: Color(0xFFFFA336)),
            _widgetPromise(),
          ],
        ),
      ),
    );
  }

  Widget _widgetTitle({String title, Color color, bool showMore = false}) {
    return Stack(
      children: [
        Positioned(
          left: 30.w,
          bottom: 30.w,
          child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.49),
              borderRadius: BorderRadius.circular(38.w),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 44.w, horizontal: 30.w),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title ?? "",
                  style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorText, fontWeight: FontWeight.bold),
                ),
              ),
              Offstage(
                offstage: !showMore,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.seeMore,
                      style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 28.w,
                      color: Styles.color999999,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _widgetBanner() {
    return Container(
      width: 750.w,
      height: 440.w,
      child: FutureBuilder(
        future: _getAdList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<AdModel> list = snapshot.data;
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                var item = list[index];
                return GestureDetector(
                  onTap: () {
                    adTapAction(item);
                  },
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              itemCount: list?.length ?? 0,
              pagination: new SwiperCustomPagination(
                builder: (context, config) => MyPagination(
                  length: list?.length ?? 0,
                  config: config,
                  alignment: Alignment(0, 0.76),
                ),
              ),
            );
          } else {
            return Image.asset(
              "assets/images/placeholder.png",
              fit: BoxFit.cover,
            );
          }
        },
      ),
    );
  }

  Widget _widgetNav() {
    return Container(
      width: 690.w,
      height: 159.w,
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Row(
        children: List<Widget>.generate(
          _navList.length,
          (index) => Expanded(
            child: RawMaterialButton(
              onPressed: () {
                _onNavItemTap(context, index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 51.w,
                    height: 51.w,
                    child: Image.asset('assets/images/home/icon_${_navList[index].image}.png', fit: BoxFit.contain),
                  ),
                  SizedBox(height: 18.w),
                  Text(_navList[index].title, style: Styles.normalFont(fontSize: 22.sp, color: Styles.color666666)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetKnow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      margin: EdgeInsets.only(top: 34.h),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 187.w,
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(16.w),
                    color: Color(0xFFFFF5F3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('了解墨岚', style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 19.w),
                      Text('了解戏墨更多知识', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset('assets/images/home/pic_learn_more.png', width: 113.w, height: 176.w),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 28.w,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 187.w,
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.w),
                  clipBehavior: Clip.hardEdge,
                  decoration: Styles.normalDecoration.copyWith(
                    borderRadius: BorderRadius.circular(16.w),
                    color: Color(0xFFFFFCF3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('如何上课', style: Styles.normalFont(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 19.w),
                      Text('轻松了解上课渠道', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset('assets/images/home/pic_learn_how.png', width: 108.w, height: 185.w),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetExperience() {
    return Container(
      child: Column(
        children: [
          Container(
            width: 750.w,
            height: 308.w,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: _experienceList?.length ?? 0,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: CardExperience(
                  width: 513.w,
                  height: 308.w,
                  data: _experienceList[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetNewCourse() {
    return Container(
      child: Container(
        width: 750.w,
        height: 379.w,
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
          itemCount: _newCourseList?.length ?? 0,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: CardNewCourse(
              width: 590.w,
              height: 339.w,
              data: _newCourseList[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetPromise() {
    return Container(
      width: 690.w,
      clipBehavior: Clip.hardEdge,
      decoration: Styles.normalDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 48.w,
            children: List.generate(
              _promiseList.length,
              (index) {
                var item = _promiseList[index];
                return Container(
                  width: 300.w,
                  margin: EdgeInsets.only(top: 40.w),
                  child: Column(
                    children: [
                      Image.asset('assets/images/home/info_${item['icon']}.png', width: 74.w, height: 74.w, fit: BoxFit.contain),
                      SizedBox(height: 17.w),
                      Text(item['title'], style: Styles.normalFont(fontSize: 24.sp)),
                      SizedBox(height: 17.w),
                      Text(item['info'], style: Styles.normalFont(fontSize: 22.sp, color: Color(0xFFC1B0A4), height: 1.5), textAlign: TextAlign.center),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: 690.w,
            height: 76.w,
            margin: EdgeInsets.only(top: 26.w),
            color: Color(0xFFFFC2A3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage('assets/images/chat/icon_warn.png'),
                  size: 30.w,
                  color: Colors.white,
                ),
                SizedBox(width: 13.w),
                Text('注意：开课后 3课时后 不可退款', style: Styles.normalFont(fontSize: 26.sp, color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
