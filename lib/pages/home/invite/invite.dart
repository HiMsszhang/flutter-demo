import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/invite_jump_button.dart';
import 'package:molan_edu/widgets/invite_card.dart';
import 'dart:ui';

import 'package:molan_edu/widgets/invite_share.dart';

class InvitePage extends StatefulWidget {
  final bool isInvite;
  InvitePage({
    Key key,
    this.isInvite = false,
  }) : super(key: key);

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: MediaQueryData.fromWindow(window).padding.top,
            color: Color(0xFFFFC2AA),
          ),
        ),
        Positioned.fill(
          top: MediaQueryData.fromWindow(window).padding.top,
          child: Container(color: Color(0xFFFEF7EB)),
        ),
        Positioned(
          top: MediaQueryData.fromWindow(window).padding.top,
          left: 0,
          child: Image.asset('assets/images/invite/bg_invite.png', width: 750.w, height: 1334.w, fit: BoxFit.contain),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            brightness: Brightness.dark,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 33.w,
                color: Styles.colorBg,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              '邀请有礼',
              style: Styles.normalFont(fontSize: 36.sp, color: Color.fromRGBO(255, 255, 255, 1), fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: InviteWidget(),
          ),
        ),
      ],
    );
  }
}

class InviteWidget extends StatelessWidget {
  const InviteWidget({
    Key key,
  }) : super(key: key);

  _buildShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InviteShare();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 396.w),
      child: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(left: 34.w, right: 34.w, bottom: 26.w),
            padding: EdgeInsets.only(top: 81.w),
            width: 681.w,
            // height: 796.w,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(30.w),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(233, 202, 163, 0.5),
                  blurRadius: 26.w,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '购课可直接抵扣',
                  style: TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1),
                    fontSize: 30.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 25.w),
                Text(
                  '多邀多得上不封顶',
                  style: TextStyle(
                    fontSize: 30.w,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
                SizedBox(height: 89.w),
                InviteCard(),
                JumpButton(
                  onTap: (value) {
                    if (value == 0) {
                      _buildShowDialog(context);
                    }
                  },
                ),
                SizedBox(height: 14.w)
              ],
            ),
          ),
          Positioned(
            top: -33.w,
            child: Container(
              child: Center(
                child: Text(
                  '好友注册 各得300墨币',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 32.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              width: 405.w,
              height: 65.w,
              decoration: BoxDecoration(
                color: Color(0xFFEAA685),
                borderRadius: BorderRadius.circular(33.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
