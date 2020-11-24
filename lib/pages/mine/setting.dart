import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/apis/setting.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/models/ConfigModel.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/utils/local_storage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({
    Key key,
  }) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with UtilsMixin {
  bool _allowAutoPlay = false;
  bool _allowPlay = false;
  bool _allowDownload = false;
  ConfigModel _data;

  @override
  void initState() {
    super.initState();
    _initFromCache();
    delayed(() async {
      await _load();
    });
  }

  _clear() {
    LocalStorage.clear();
  }

  _load() async {
    await _getSetting();
    setState(() {});
  }

  _logOut() async {
    await context.read<UserState>().logOut();
    NavigatorUtils.pushNamedAndRemoveUntil(context, '/');
  }

  Future _getSetting() async {
    DataResult result = await SettingAPI.config(
      name: 'customer_service_center',
    );
    _data = result.data;
  }

  _initFromCache() async {
    _allowAutoPlay = await LocalStorage.get('_allowAutoPlay') ?? false;
    _allowPlay = await LocalStorage.get('_allowPlay');
    _allowDownload = await LocalStorage.get('_allowDownload');

    print('>>>>>>>>>>>>>>>>>>>>>>>');
    print('$_allowAutoPlay+$_allowPlay+$_allowDownload');
    setState(() {});
  }

  _saveInfo() async {
    await LocalStorage.set('_allowAutoPlay', _allowAutoPlay);
    await LocalStorage.set('_allowPlay', _allowPlay);
    await LocalStorage.set('_allowDownload', _allowDownload);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '设置',
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          _widgetItem(
              title: '关于墨岚',
              icon: 'about',
              onTap: () {
                NavigatorUtils.pushNamed(context, '/webview', arguments: {'url': _data.value});
              }),
          _widgetItem(
              title: '隐私策略',
              icon: 'privacy',
              onTap: () {
                NavigatorUtils.pushNamed(context, '/webview', arguments: {'url': _data.value});
              }),
          _widgetItem(
            title: '视频自动播放',
            icon: 'autoplay',
            action: SizedBox(
              width: 69.w,
              height: 42.w,
              child: Transform.scale(
                scale: .7,
                child: CupertinoSwitch(
                  value: _allowAutoPlay,
                  activeColor: Color(0xFFFFA06B),
                  onChanged: (value) {
                    setState(() {
                      _allowAutoPlay = value;
                    });
                    _saveInfo();
                  },
                ),
              ),
            ),
          ),
          _widgetItem(
            title: '允许非WiFi网络播放',
            icon: 'play',
            action: SizedBox(
              width: 69.w,
              height: 42.w,
              child: Transform.scale(
                scale: .7,
                child: CupertinoSwitch(
                  value: _allowPlay,
                  activeColor: Color(0xFFFFA06B),
                  onChanged: (value) {
                    setState(() {
                      _allowPlay = value;
                    });
                    _saveInfo();
                  },
                ),
              ),
            ),
          ),
          _widgetItem(
            title: '允许非WiFi网络下载',
            icon: 'download',
            action: SizedBox(
              width: 69.w,
              height: 42.w,
              child: Transform.scale(
                scale: .7,
                child: CupertinoSwitch(
                  value: _allowDownload,
                  activeColor: Color(0xFFFFA06B),
                  onChanged: (value) {
                    setState(() {
                      _allowDownload = value;
                    });
                    _saveInfo();
                  },
                ),
              ),
            ),
          ),
          _widgetItem(
              title: '清除缓存',
              icon: 'clear',
              onTap: () {
                _clear();
              }),
          _widgetItem(
              title: '注销账户',
              icon: 'delete',
              onTap: () {
                NavigatorUtils.pushNamed(context, "/user.logout");
              }),
          GestureDetector(
            onTap: _logOut,
            child: Container(
              width: 690.w,
              height: 90.w,
              margin: EdgeInsets.symmetric(horizontal: 30.w).copyWith(top: 70.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90.w),
                color: Theme.of(context).accentColor,
              ),
              child: Text('退出登录', style: Styles.normalFont(fontSize: 32.sp, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetItem({String title, String icon, VoidCallback onTap, Widget action}) {
    return RawMaterialButton(
      onPressed: onTap,
      child: Container(
        height: 136.w,
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset('assets/images/mine/setting_$icon.png', width: 46.w, height: 46.w, fit: BoxFit.contain),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Text(title, style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorText)),
                  ),
                  action ?? Icon(Icons.arrow_forward_ios, size: 30.w, color: Styles.color999999),
                ],
              ),
            ),
            Container(width: 690.w, height: 1, color: Color(0xFFF5F5F5)),
          ],
        ),
      ),
    );
  }
}
