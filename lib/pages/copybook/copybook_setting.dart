import 'dart:io';

import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';

import 'package:image_pickers/image_pickers.dart';
import 'package:molan_edu/providers/copybook_state.dart';

class CopybookSettingPage extends StatefulWidget {
  const CopybookSettingPage({Key key}) : super(key: key);

  @override
  _CopybookSettingPageState createState() => _CopybookSettingPageState();
}

class _CopybookSettingPageState extends State<CopybookSettingPage> with UtilsMixin {
  CopybookState _config;

  String get currentGridColor {
    String color = _config.getGridColor;
    return color;
  }

  @override
  void initState() {
    super.initState();
    _config = context.read<CopybookState>();
  }

  _onPickCustomBgImage() async {
    List<Media> list = await ImagePickers.pickerPaths(
      selectCount: 1,
      compressSize: 1500,
      cropConfig: CropConfig(enableCrop: true),
    );
    Media file = list[0];
    if (file != null) {
      _config.setCustomPaperPath(file.path);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '字帖设置',
      body: ListView(
        children: <Widget>[
          _widgetTitle(icon: 'wangge', title: '网格设置'),
          _widgetGridSetting(),
          _widgetDivider(),
          _widgetTitle(icon: 'ziyuan', title: '资源设置'),
          _widgetOptionList<int>(
            options: _config.resourceList,
            active: _config.getResource,
            onChange: (v) {
              _config.setConfig(resource: v);
              if (mounted) setState(() {});
            },
          ),
          _widgetDivider(vertical: 0),
          _widgetTitle(icon: 'paiban', title: '排版设置'),
          _widgetOptionList<int>(
            options: _config.composeList,
            active: _config.getCompose,
            onChange: (v) {
              _config.setConfig(compose: v);
              if (mounted) setState(() {});
            },
          ),
          _widgetDivider(vertical: 0),
          _widgetTitle(icon: 'yanse', title: '字体颜色设置'),
          _widgetOptionList<int>(
            options: _config.fontColorList,
            active: _config.getFontColor,
            onChange: (v) {
              _config.setConfig(fontColor: v);
              if (mounted) setState(() {});
            },
          ),
          _widgetDivider(vertical: 0),
          _widgetTitle(icon: 'beijing', title: '背景设置'),
          _widgetBgList(),
          SizedBox(height: kBottomNavigationBarHeight)
        ],
      ),
    );
  }

  Widget _widgetTitle({
    String icon,
    String title,
    String subTitle = '',
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 28.h).copyWith(bottom: 20.h),
      child: Row(
        children: <Widget>[
          Image.asset('assets/images/copybook/$icon.png', width: 28.w, height: 28.w),
          SizedBox(width: 24.w),
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(fontSize: 28.sp, color: Styles.color2F3D58, fontWeight: FontWeight.bold),
              children: [TextSpan(text: subTitle, style: TextStyle(fontSize: 16.w))],
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetDivider({double vertical = 14}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: vertical).copyWith(left: 28.w),
      child: Divider(height: 0.5, color: Styles.colorE3E5EA),
    );
  }

  Widget _widgetGridSetting() {
    List<CopybookGridItem> gridItems = _config.gridItems;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w).copyWith(right: 8.w, top: 16.h),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 228.w,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: gridItems.length,
                itemBuilder: (c, i) {
                  CopybookGridItem item = gridItems[i];
                  bool hasActive = _config.getGridType == item.type;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        if (hasActive) return;
                        if (_config.getGridColor == 'none') return;
                        _config.setConfig(gridType: item.type);
                        if (mounted) setState(() {});
                      },
                      child: Column(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/copybook/grid/${item.image}_${currentGridColor}_m.png',
                                width: 180.w,
                                height: 180.w,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                width: 180.w,
                                height: 180.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(color: hasActive ? Styles.color444E6B : Colors.transparent, width: 1.5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            item.title,
                            style: TextStyle(color: Styles.colorText, fontSize: 24.w, height: 1),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: 144.w,
            child: Column(
              children: <Widget>[
                _widgetGridColorOption('none'),
                _widgetGridColorOption('red'),
                _widgetGridColorOption('white'),
                _widgetGridColorOption('green'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetGridColorOption(String color) {
    bool hasActive = _config.getGridColor == color;
    String text;
    String gridColor;
    switch (color) {
      case 'red':
        text = '红色';
        gridColor = 'red';
        break;
      case 'white':
        text = '白色';
        gridColor = 'white';
        break;
      case 'green':
        text = '绿色';
        gridColor = 'green';
        break;
      default:
        text = '无框';
        gridColor = 'white';
    }
    return GestureDetector(
      onTap: () {
        if (hasActive) return;
        if (color == 'none') {
          _config.setConfig(gridType: 'none');
        } else {
          if (_config.getGridType == 'none') {
            _config.setConfig(gridType: 'mizi');
          }
        }
        _config.setConfig(gridColor: color);

        if (mounted) setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        margin: EdgeInsets.only(bottom: 12.h),
        width: 84.w,
        decoration: BoxDecoration(
          color: hasActive ? Color.fromRGBO(47, 61, 88, 0.1) : Colors.transparent,
          border: Border.all(color: hasActive ? Styles.colorTheme : Colors.transparent, width: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/copybook/grid_${gridColor}_style.png',
              width: 18.w,
              height: 18.w,
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(color: Styles.colorTheme, fontSize: 20.sp, height: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetOptionList<T>({List<CopybookOption> options, T active, ValueChanged onChange}) {
    Size size = MediaQuery.of(context).size;
    double itemW = (size.width) / options.length;
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(80)).copyWith(bottom: 16.h),
      child: Row(
        children: List.generate(
          options.length,
          (i) {
            CopybookOption<T> option = options[i];
            bool hasActive = active == option.value;
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (TapDownDetails e) {
                  if (hasActive) return;
                  if (onChange != null) onChange(option.value);
                },
                child: Container(
                  width: itemW,
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/copybook/option_${hasActive ? 'on' : 'ellipse'}.png',
                        width: 24.w,
                        height: 24.w,
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        option.title,
                        style: TextStyle(color: Styles.color2F3D58, fontSize: 20.sp),
                      ),
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

  Widget _widgetBgList() {
    List<CopybookPaperItem> paperList = _config.paperList;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 20.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w).copyWith(top: 16.h),
      itemCount: paperList.length,
      itemBuilder: (c, i) {
        CopybookPaperItem item = paperList[i];
        String image = item.image;
        bool hasActive = item.type == _config.getPaperType;
        if (!['none', 'custom'].contains(item.type)) {
          image += '_m';
        }
        return GestureDetector(
          onTap: () {
            if (item.type == 'custom') {
              _onPickCustomBgImage();
            }
            if (hasActive) return;
            _config.setConfig(paperType: item.type);
            if (mounted) setState(() {});
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Styles.colorCBCBCB, width: 1.5),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: hasActive ? Styles.color3C4962 : Colors.transparent, width: 1.5),
                    ),
                    padding: EdgeInsets.all(1),
                    width: 88.w,
                    height: 88.w,
                    child: ClipOval(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: item.type != 'custom'
                            ? Image.asset(
                                'assets/images/copybook/background/$image.png',
                                fit: BoxFit.cover,
                              )
                            : (_config.customPaperPath == null
                                ? Image.asset(
                                    'assets/images/copybook/background/$image.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File.fromUri(Uri.file(_config.customPaperPath)),
                                  )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.title,
                  style: TextStyle(fontSize: 20.sp, color: Styles.color2F3D58),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
