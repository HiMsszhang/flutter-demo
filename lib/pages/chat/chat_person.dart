import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';

class ChatPersonPage extends StatefulWidget {
  const ChatPersonPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatPersonPageState createState() => _ChatPersonPageState();
}

class _ChatPersonPageState extends State<ChatPersonPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: 'Vicky老师',
      backgroundColor: Color(0xFFF1F1F1),
      body: Column(
        children: [
          _widgetFloatInfo(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              reverse: true,
              scrollDirection: Axis.vertical,
              children: [
                _widgetLeft(),
                _widgetLeft(type: 2),
                _widgetRight(),
                _widgetRight(type: 2),
              ],
            ),
          ),
          SafeArea(
            top: false,
            bottom: true,
            child: Container(
              width: double.infinity,
              height: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: Styles.normalDecoration.copyWith(
                color: Color(0xFFF9F9F9),
                border: Border(top: BorderSide(width: 1, color: Color(0xFFEEEEEE))),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset('assets/images/chat/icon_voice.png', width: 56.w, height: 56.w),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      height: 64.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64.w),
                        border: Border.all(width: 1, color: Color(0xFFEEEEEE)),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                  Image.asset('assets/images/chat/icon_emoji.png', width: 56.w, height: 56.w),
                  SizedBox(width: 20.w),
                  Image.asset('assets/images/chat/icon_more.png', width: 56.w, height: 56.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetLeft({int type = 1}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonAvatar(size: 72.w),
          SizedBox(width: 20.w),
          type == 1 ? _widgetMessageTalk() : _widgetMessagePic(),
        ],
      ),
    );
  }

  Widget _widgetRight({int type = 1}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          type == 1 ? _widgetMessageTalk(isMe: true) : _widgetMessagePic(),
          SizedBox(width: 20.w),
          CommonAvatar(size: 72.w),
        ],
      ),
    );
  }

  Widget _widgetMessagePic() {
    return Container(
      width: 250.w,
      height: 307.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Image.asset(
        'assets/images/demo.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _widgetMessageTalk({bool isMe = false}) {
    return Stack(
      overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        isMe
            ? Positioned(
                top: 24.w,
                right: -8.w,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                  ),
                ),
              )
            : Positioned(
                top: 24.w,
                left: -8.w,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                  ),
                ),
              ),
        Container(
          width: 506.w,
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 26.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.w),
            color: isMe ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
            // color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          child: Text(
            '哈哈哈哈哈哈哈哈嗝哈哈哈哈哈哈哈哈嗝哈哈哈哈哈哈哈哈嗝哈哈哈哈哈哈哈哈嗝哈哈哈哈哈哈哈哈嗝',
            style: Styles.normalFont(fontSize: 28.sp, height: 1.5, color: isMe ? Colors.white : Styles.colorText),
            textAlign: isMe ? TextAlign.right : TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _widgetFloatInfo() {
    return Container(
      width: 690.w,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.w),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/images/chat/icon_warn.png'),
                size: 20.w,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 10.w),
              Text('温馨提示', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
            ],
          ),
          SizedBox(height: 10.w),
          Text('15：00前老师在线实时回复。15：00后老师将次日回复', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666, height: 1.2)),
        ],
      ),
    );
  }
}
