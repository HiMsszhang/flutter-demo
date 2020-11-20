import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/widgets/invite_jump_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/apis/invite.dart';
import 'package:molan_edu/models/InviteModel.dart';

GlobalKey globalKey = GlobalKey();

class InviteShare extends StatefulWidget {
  InviteShare({
    Key key,
  }) : super(key: key);

  _InviteShareState createState() => _InviteShareState();
}

class _InviteShareState extends State<InviteShare> with UtilsMixin {
  InviteInfoModel _info;
  Uint8List _qr;
  bool _loadFlag = false;

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

  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getInfo();
      await _getQr();
    });
  }

  _getInfo() async {
    DataResult res = await InviteAPI.info();
    _info = res.data;
    setState(() {});
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
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 504.w,
            height: 858.w,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(color: Colors.white),
            child: RepaintBoundary(
              key: globalKey,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  image: DecorationImage(image: NetworkImage('https://molan-realse-1256995646.cos.ap-chongqing.myqcloud.com/WechatIMG162.png'), fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 95.w),
                      child: Text(_info?.name ?? '', style: Styles.normalFont(fontSize: 22.w, color: Color.fromRGBO(137, 86, 61, 1), fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 50.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset("assets/images/logo_invite.png", width: 40.w, height: 50.w),
                                SizedBox(width: 20.w),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('识别二维码注册领取 >>', style: Styles.normalFont(fontSize: 18.w, color: Colors.white, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 12.w),
                                      Text('价值¥${_info?.moMoney ?? 0}新人大礼包', style: Styles.normalFont(fontSize: 16.w, color: Colors.white, fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _loadFlag
                              ? Image.memory(
                                  _qr,
                                  width: 75.w,
                                  height: 75.w,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
                                )
                              : Container(width: 75.w, height: 75.w, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 23.w),
          SizedBox(
            width: 60.w,
            height: 60.w,
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.w),
              ),
              child: Icon(
                Icons.close,
                color: Color.fromRGBO(153, 153, 153, 1),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(height: 10.w),
          JumpButton(
            onTap: (value) {
              if (value == 0) {
                _onButtonTab(globalKey);
              }
            },
          ),
          SizedBox(height: 14.w)
        ],
      ),
    );
  }
}
