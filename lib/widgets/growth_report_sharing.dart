import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import 'package:molan_edu/widgets/common_avatar.dart';

growthreportSharing(BuildContext context) async {
  List<Map> _labelList = [
    {'title': '累计学习时长', 'label': '小时'},
    {'title': '已学习课程', 'label': '节'},
    {'title': '掌握书法字数', 'label': '个'},
    {'title': '完成作业次数', 'label': '次'},
    {'title': '当前星星数', 'label': '颗'},
    {'title': '表现优秀次数', 'label': '次'},
  ];
  GlobalKey globalKey = GlobalKey();
  _onButtonTab(GlobalKey globalKey) async {
    //检查是否有存储权限
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();

      // print(status);
      return;
    }

    BuildContext buildContext = globalKey.currentContext;

    if (null != buildContext) {
      RenderRepaintBoundary boundary = buildContext.findRenderObject();
      // 获取当前设备的像素比
      double dpr = ui.window.devicePixelRatio * 4;

      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      print('海报已保存到相册');
      return result;
    }
  }

  await Future.delayed(Duration(milliseconds: 100));
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Container(
                padding: EdgeInsets.all(30.w),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: 670.w,
                      height: 75.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/mine/bg_report.png'), fit: BoxFit.fill),
                      ),
                      child: Text(
                        '我家宝贝的专属成长报告',
                        style: Styles.normalFont(fontSize: 32.w, fontWeight: FontWeight.w600, color: Color.fromRGBO(255, 140, 108, 1)),
                      ),
                    ),
                    Container(
                      height: 640.w,
                      width: 670.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36.w), bottomRight: Radius.circular(36.w), topLeft: Radius.circular(0), topRight: Radius.circular(0)),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(30.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CommonAvatar(
                                    size: 112.w,
                                    showSex: false,
                                  ),
                                  SizedBox(width: 16.w),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '公爵大人',
                                              style: Styles.normalFont(fontSize: 30.w, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 51, 1)),
                                            ),
                                            SizedBox(width: 15.w),
                                            Image.asset('assets/images/mine/sex_male.png', width: 30.w, height: 30.w)
                                          ],
                                        ),
                                        SizedBox(height: 21.w),
                                        Text(
                                          '10岁',
                                          style: Styles.normalFont(fontSize: 24.w, color: Color.fromRGBO(102, 102, 102, 1)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.w),
                            Container(
                              width: 690.w,
                              height: 250.w,
                              child: GridView(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 55.w,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: 2,
                                ),
                                children: List.generate(_labelList.length, (index) {
                                  var item = _labelList[index];
                                  return Container(
                                    width: 330.w,
                                    height: 60.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: Styles.normalFont(fontSize: 24.w, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                        ),
                                        SizedBox(height: 16.w),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '218',
                                              style: Styles.normalFont(fontSize: 40.w, fontWeight: FontWeight.w600, color: Color.fromRGBO(255, 131, 95, 1)),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              item['label'],
                                              style: Styles.normalFont(fontSize: 24.w, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '我家宝贝正在“墨岚教育”学习书法',
                                          style: Styles.normalFont(fontSize: 28.w, fontWeight: FontWeight.w500, color: Color.fromRGBO(51, 51, 51, 1)),
                                        ),
                                        SizedBox(height: 24.w),
                                        Text(
                                          '扫描二维码和我一起吧',
                                          style: Styles.normalFont(fontSize: 28.w, fontWeight: FontWeight.w500, color: Color.fromRGBO(51, 51, 51, 1)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30.w),
                                  Container(width: 131.w, height: 131.w, child: Image.asset('assets/images/demo.png', fit: BoxFit.fill)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 174.w),
            Stack(
              children: [
                Container(
                  width: 750.w,
                  padding: EdgeInsets.all(30.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.w),
                      topLeft: Radius.circular(16.w),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 750.w,
                        height: 32.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '分享到',
                              style: Styles.normalFont(fontSize: 30.w, fontWeight: FontWeight.w600, color: Color.fromRGBO(51, 51, 51, 1)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.w),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: FlatButton(
                                onPressed: () => {_onButtonTab(globalKey)},
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/invite/icon_wechat.png', width: 51.w, height: 51.w),
                                    SizedBox(height: 14.w),
                                    Text(
                                      '微信',
                                      style: Styles.normalFont(fontSize: 24.w, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                onPressed: () => {_onButtonTab(globalKey)},
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/invite/icon_moment.png', width: 51.w, height: 51.w),
                                    SizedBox(height: 14.w),
                                    Text(
                                      '朋友圈',
                                      style: Styles.normalFont(fontSize: 24.w, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    padding: EdgeInsets.all(8.w),
                    icon: Icon(
                      Icons.close,
                      size: 35.w,
                      color: Styles.color666666,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
