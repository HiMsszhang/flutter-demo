import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:fluwx/fluwx.dart';
import 'package:molan_edu/apis/invite.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:molan_edu/models/ReportModel.dart';

class ReportShare extends StatefulWidget {
  final MyReportDetailModel data;
  ReportShare({
    Key key,
    this.data,
  }) : super(key: key);

  _ReportShareState createState() => _ReportShareState();
}

class _ReportShareState extends State<ReportShare> with UtilsMixin {
  List<Map> _labelList = [
    {'title': '累计学习时长', 'label': '小时'},
    {'title': '已学习课程', 'label': '节'},
    {'title': '掌握书法字数', 'label': '个'},
    {'title': '完成作业次数', 'label': '次'},
    {'title': '当前星星数', 'label': '颗'},
    {'title': '表现优秀次数', 'label': '次'},
  ];
  GlobalKey globalKey = GlobalKey();

  Uint8List _qr;
  bool _loadFlag = false;

  _onButtonTab(GlobalKey globalKey, int index) async {
    //检查是否有存储权限
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      return;
    }
    BuildContext buildContext = globalKey.currentContext;
    if (null != buildContext) {
      RenderRepaintBoundary boundary = buildContext.findRenderObject();
      // 获取当前设备的像素比
      double dpr = ui.window.devicePixelRatio * 4;

      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      try {
        EasyLoading.show();
        await shareToWeChat(WeChatShareImageModel(
          WeChatImage.binary(
            byteData.buffer.asUint8List(),
          ),
          scene: index == 0 ? WeChatScene.SESSION : WeChatScene.TIMELINE,
        ));

        EasyLoading.dismiss();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getQr();
    });
  }

  _labelItem(int index) {
    switch (index) {
      case 0:
        return widget?.data?.totalDuration;
        break;
      case 1:
        return widget?.data?.totalHours;
        break;
      case 2:
        return widget?.data?.totalWordNum;
        break;
      case 3:
        return widget?.data?.totalComplete;
        break;
      case 4:
        return widget?.data?.starsNum;
        break;
      case 5:
        return widget?.data?.excellentNum;
        break;
      default:
    }
  }

  _getQr() async {
    DataResult res = await InviteAPI.qrCode();
    var uri = res.data['qrcode'];
    _qr = base64Decode(uri.split(',').last);
    _loadFlag = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
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
                    width: 690.w,
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
                    width: 690.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36.w), bottomRight: Radius.circular(36.w), topLeft: Radius.circular(0), topRight: Radius.circular(0)),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(30.w),
                            child: Row(
                              children: [
                                CommonAvatar(
                                  size: 102.w,
                                  showSex: false,
                                  avatar: data?.user?.avatar ?? '',
                                ),
                                SizedBox(width: 16.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(data?.user?.name ?? '', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold, height: 1)),
                                        SizedBox(width: 15.w),
                                        _widgetSex(data?.user?.gender ?? 1),
                                      ],
                                    ),
                                    SizedBox(height: 20.w),
                                    Text('${data?.user?.age ?? 0}岁', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Wrap(
                              runSpacing: 55.w,
                              spacing: 0,
                              children: List.generate(
                                _labelList.length,
                                (index) => Container(
                                  width: 220.w,
                                  child: Column(
                                    children: [
                                      Text(_labelList[index]['title'], style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                                      SizedBox(height: 16.w),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${_labelItem(index) ?? ""}', style: Styles.normalFont(fontSize: 40.sp, color: Color(0xFFFF835F), fontWeight: FontWeight.bold)),
                                          Text(_labelList[index]['label'], style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '我家宝贝正在"墨岚教育"学习书法',
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
                                _loadFlag
                                    ? Image.memory(
                                        _qr,
                                        width: 131.w,
                                        height: 131.w,
                                        fit: BoxFit.fill,
                                        errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                                      )
                                    : Container(width: 75.w, height: 75.w, color: Colors.grey),
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
                              onPressed: () => {_onButtonTab(globalKey, 0)},
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
                              onPressed: () => {_onButtonTab(globalKey, 1)},
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
  }

  Widget _widgetSex(int sex) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
          width: 30.w,
          height: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            color: sex == 1 ? Color(0xFF90D2F8) : Color(0xFFF8BE90),
          ),
          child: Icon(
            sex == 1 ? MyIcons.Iconmale : MyIcons.Iconfemale,
            size: 14.w,
            color: Colors.white,
          )),
    );
  }
}
