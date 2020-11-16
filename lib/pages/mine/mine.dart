import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/models/UserModel.dart';
import 'package:molan_edu/providers/user_state.dart';

class MinePage extends StatefulWidget {
  const MinePage({
    Key key,
  }) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with UtilsMixin, AutomaticKeepAliveClientMixin<MinePage> {
  @override
  bool get wantKeepAlive => true;

  List<Map> _mineList = [
    {"title": "我的课程", "subtitle": "已购买的课程", "name": "course"},
    {"title": "我的收藏", "subtitle": "收藏老师/课程", "name": "favorite"},
    {"title": "我的邀请", "subtitle": "我邀请的好友注册", "name": "invite"},
  ];

  List<Map> _itemList = [
    {"title": "我的报告", "name": "report"},
    {"title": "我的班主任", "name": "headmaster"},
    {"title": "客服中心", "name": "services"},
    // {"title": "帮助与反馈", "name": "help"},
    {"title": "设置", "name": "setting"},
  ];

  UserModel _user = new UserModel();
  bool hasLogin = false;

  @override
  void initState() {
    super.initState();
    hasLogin = context.read<UserState>().hasLogin;
    delayed(() {
      if (!hasLogin) toLoginPopup();
    });
  }

  _onNavItemTapped(item) {
    if (!hasLogin) {
      toLoginPopup();
      return;
    }
    switch (item['name']) {
      case "course":
        NavigatorUtils.pushNamed(context, '/mine.course');
        break;
      case "favorite":
        NavigatorUtils.pushNamed(context, '/mine.favorite');
        break;
      case "invite":
        NavigatorUtils.pushNamed(context, '/mine.invite');
        break;
    }
  }

  _onListItemTapped(item) {
    if (!hasLogin) {
      toLoginPopup();
      return;
    }
    switch (item['name']) {
      case "headmaster":
        NavigatorUtils.pushNamed(context, '/mine.headmaster');
        break;
      case "report":
        NavigatorUtils.pushNamed(context, '/mine.report');
        break;
      case "setting":
        NavigatorUtils.pushNamed(context, '/setting');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _user = context.watch<UserState>().userInfo;
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
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  brightness: Brightness.dark,
                  title: Text(
                    S.current.mineTitle,
                    style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                _widgetHeader(),
                _widgetMine(),
                _widgetList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.w, 34.w, 0, 68.w),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          hasLogin ? NavigatorUtils.pushNamed(context, '/mine.info.edit') : toLoginPopup();
        },
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonAvatar(avatar: _user?.avatar ?? '', sex: _user.gender),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            hasLogin ? _user?.name : '立即登录',
                            style: Styles.normalFont(fontSize: 34.sp, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 33.w),
                          Text(
                            '${_user?.age ?? 0}岁',
                            style: Styles.normalFont(fontSize: 30.sp, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.w),
                      UnconstrainedBox(
                        child: Container(
                          height: 42.w,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(42.w),
                            color: Color.fromRGBO(255, 255, 255, .21),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/common/icon_star_outline.png', width: 26.w, height: 25.w),
                              SizedBox(width: 11.w),
                              Text('${_user?.starsNum ?? 0}星星', style: Styles.normalFont(fontSize: 24.sp, color: Colors.white, height: 1.2)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10.w,
              right: 20.w,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: ImageIcon(
                  AssetImage('assets/images/mine/icon_edit.png'),
                  size: 34.w,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetMine() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(163, 163, 163, 0.2), blurRadius: 30.w),
        ],
      ),
      child: Row(
        children: List.generate(
          _mineList.length,
          (index) {
            var item = _mineList[index];
            return Expanded(
              child: RawMaterialButton(
                onPressed: () {
                  _onNavItemTapped(item);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 50.w),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/mine/icon_${item['name']}.png',
                        width: 58.w,
                        height: 58.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 24.w),
                      Text(item['title'], style: Styles.normalFont(fontSize: 26.sp, color: Styles.colorText)),
                      SizedBox(height: 15.w),
                      Text(item['subtitle'], style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _widgetList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w).copyWith(top: 20.w, bottom: 60.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(163, 163, 163, 0.2), blurRadius: 30.w),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: List.generate(
          _itemList.length,
          (index) {
            var item = _itemList[index];
            return Stack(
              children: [
                RawMaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 40.w),
                  onPressed: () {
                    _onListItemTapped(item);
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/mine/icon_${item['name']}.png', width: 46.w, height: 46.w, fit: BoxFit.contain),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Text(item['title'], style: Styles.normalFont(fontSize: 28.sp, color: Styles.colorText)),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 44.w,
                  right: 44.w,
                  child: Container(width: 602.w, height: index == _itemList.length - 1 ? 0 : 0.5, color: Color(0xFFF5F5F5)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
