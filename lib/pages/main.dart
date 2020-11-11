import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/pages/home/home.dart';
import 'package:molan_edu/pages/course/course.dart';
import 'package:molan_edu/pages/timetable/timetable.dart';
import 'package:molan_edu/pages/chat/chat.dart';
import 'package:molan_edu/pages/mine/mine.dart';
import 'package:molan_edu/utils/local_storage.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/enums/user_allow_type_enum.dart';
import 'package:tencent_im_plugin/enums/user_gender_enum.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/apis/user.dart';
import 'package:molan_edu/models/UserModel.dart';

class TabItem {
  String title;
  String image;
  String selectedImage;
  Widget tabView;
  bool isSelected;
  bool isMain;
  int index;

  TabItem(
    this.title, {
    this.image,
    this.selectedImage,
    this.tabView,
    this.isMain = false,
    this.isSelected = false,
    this.index,
  });
}

class MainPage extends StatefulWidget {
  final int page;
  const MainPage({
    Key key,
    this.page = 0,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with UtilsMixin {
  int _selectedIndex = 0;
  List<TabItem> _tabItems;

  PageController _pageController = PageController();

  DateTime mLastDateTime;
  bool hasLogin = false;
  UserModel _user;

  @override
  void initState() {
    super.initState();
    _tabItems = [
      TabItem(
        S.current.home,
        image: 'assets/images/tab/tab_home.png',
        selectedImage: 'assets/images/tab/tab_home_selected.png',
        tabView: HomePage(
          jumpToPage: (index) => _jumpToPage(index),
        ),
        index: 0,
      ),
      TabItem(
        S.current.course,
        image: 'assets/images/tab/tab_course.png',
        selectedImage: 'assets/images/tab/tab_course_selected.png',
        tabView: CoursePage(),
        index: 1,
      ),
      TabItem(
        S.current.timetable,
        image: 'assets/images/tab/tab_timetable.png',
        selectedImage: 'assets/images/tab/tab_timetable_selected.png',
        tabView: TimetablePage(),
        isMain: true,
        index: 2,
      ),
      TabItem(
        S.current.message,
        image: 'assets/images/tab/tab_chat.png',
        selectedImage: 'assets/images/tab/tab_chat_selected.png',
        tabView: ChatPage(),
        index: 3,
      ),
      TabItem(
        S.current.mine,
        image: 'assets/images/tab/tab_mine.png',
        selectedImage: 'assets/images/tab/tab_mine_selected.png',
        tabView: MinePage(),
        index: 4,
      ),
    ];
    _load();
  }

  _load() {
    delayed(() async {
      await context.read<UserState>().getUser();
      _user = context.read<UserState>().userInfo;
      if (widget.page != 0) {
        _jumpToPage(widget.page);
      }
      var isFirst = await LocalStorage.getJSON(Config.S_FIRST) ?? null;
      if (isFirst == null) {
        Navigator.pushNamed(context, '/guide');
      }
      hasLogin = context.read<UserState>().hasLogin;
      if (hasLogin) {
        await _imLogin();
      }
    });
  }

  Future<bool> _doubleExit() {
    var nowDateTime = DateTime.now();
    if (mLastDateTime != null && nowDateTime.millisecondsSinceEpoch - mLastDateTime.millisecondsSinceEpoch < 2000) {
      return Future.value(true);
    } else {
      mLastDateTime = DateTime.now();

      return Future.value(false);
    }
  }

  void _jumpToPage(int index) {
    _pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _imLogin() async {
    try {
      DataResult res = await UserAPI.imSign();
      String sign = res.data['sign'];
      await LocalStorage.setJSON(Config.IM_SIGN, sign);
      await TencentImPlugin.login(
        userID: _user.id.toString() + 'user',
        userSig: sign,
      );
      TencentImPlugin.setSelfInfo(
        info: UserEntity(
          nickName: _user.name,
          faceUrl: _user.avatar,
          allowType: UserAllowTypeEnum.AllowAny,
          gender: _user.gender == 1 ? UserGenderEnum.Male : UserGenderEnum.Female,
          // customInfo: {"Id": _user.id.toString()},
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _doubleExit,
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _tabItems.length,
              itemBuilder: (context, idx) => _tabItems[idx].tabView,
              controller: _pageController,
              onPageChanged: onPageChanged,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).primaryColor,
              child: Container(
                height: 98.h,
                child: Row(
                  children: List<Widget>.generate(
                    _tabItems.length,
                    (index) => _widgetTabItem(
                      item: _tabItems[index],
                      onTap: () => _jumpToPage(index),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetTabItem({TabItem item, VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _selectedIndex == item.index ? item.selectedImage : item.image,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10.w),
            Text(
              item.title,
              style: Styles.normalFont(fontSize: 20.sp, color: _selectedIndex == item.index ? Theme.of(context).accentColor : Color(0xFFC7C7C7)),
            ),
          ],
        ),
      ),
    );
  }
}
