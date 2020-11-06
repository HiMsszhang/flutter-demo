import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/utils/local_storage.dart';

import 'package:molan_edu/widgets/custom_switch.dart';

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

  @override
  void initState() {
    super.initState();
  }

  _clear() {
    LocalStorage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '设置',
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          _widgetItem(title: '关于墨岚', icon: 'about', onTap: () {}),
          _widgetItem(title: '隐私策略', icon: 'privacy', onTap: () {}),
          _widgetItem(
            title: '视频自动播放',
            icon: 'autoplay',
            action: CustomSwitch(
              value: _allowAutoPlay,
              onChanged: (value) {
                setState(() {
                  _allowAutoPlay = !_allowAutoPlay;
                });
              },
            ),
          ),
          _widgetItem(
            title: '允许非WiFi网络播放',
            icon: 'play',
            action: CustomSwitch(
              value: _allowPlay,
              onChanged: (value) {
                setState(() {
                  _allowPlay = !_allowPlay;
                });
              },
            ),
          ),
          _widgetItem(
            title: '允许非WiFi网络下载',
            icon: 'download',
            action: CustomSwitch(
              value: _allowDownload,
              onChanged: (value) {
                setState(() {
                  _allowDownload = !_allowDownload;
                });
              },
            ),
          ),
          _widgetItem(
              title: '清除缓存',
              icon: 'clear',
              onTap: () {
                _clear();
              }),
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
