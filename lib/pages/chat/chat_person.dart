import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class ChatPersonPage extends StatefulWidget {
  final String id;
  final String name;
  const ChatPersonPage({
    Key key,
    this.id,
    this.name,
  }) : super(key: key);

  @override
  _ChatPersonPageState createState() => _ChatPersonPageState();
}

class _ChatPersonPageState extends State<ChatPersonPage> with UtilsMixin {
  String _message;
  List<MessageEntity> _list = [];
  TextEditingController _inputController;
  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    delayed(() async {
      _getData();
    });
  }

  _getData() async {
    _list = await TencentImPlugin.getC2CHistoryMessageList(userID: widget.id, count: 20);
    print(_list[0].toJson());
    setState(() {});
  }

  _onInput(String value) {
    setState(() {
      _message = value;
    });
  }

  _send() async {
    await _sendMessage(TextMessageNode(content: _message));
    _message = '';
    _inputController.clear();
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  _sendMessage(MessageNode node) async {
    String msgId = await TencentImPlugin.sendMessage(
      node: node,
      receiver: widget.id,
    );

    _list.insert(
      0,
      MessageEntity(
        msgID: msgId,
        node: node,
        elemType: node.nodeType,
        self: true,
      ),
    );

    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: widget.name ?? "",
      backgroundColor: Color(0xFFF1F1F1),
      body: Column(
        children: [
          _widgetFloatInfo(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                var item = _list[index];
                return item.self ? _widgetRight(item) : _widgetLeft(item);
              },
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
                        onChanged: (value) {
                          _onInput(value);
                        },
                        onSubmitted: (value) async {
                          await _send();
                        },
                        controller: _inputController,
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/chat/icon_emoji.png', width: 56.w, height: 56.w),
                  SizedBox(width: 20.w),
                  _message != ''
                      ? Container(
                          height: 56.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.w),
                            color: Theme.of(context).accentColor,
                          ),
                          child: InkWell(
                            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // padding: EdgeInsets.zero,
                            onTap: () async {
                              await _send();
                            },
                            child: Text(
                              '发送',
                              style: Styles.normalFont(color: Colors.white),
                            ),
                          ),
                        )
                      : Image.asset('assets/images/chat/icon_more.png', width: 56.w, height: 56.w),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _returnMessage(MessageEntity item) {
    switch (item.elemType) {
      case MessageElemTypeEnum.Text:
        return _widgetMessageTalk(item, isMe: item.self);
        break;
      case MessageElemTypeEnum.Image:
        return _widgetMessagePic(item);
        break;
      default:
        return _widgetMessageTalk(item, isMe: item.self);
    }
  }

  Widget _widgetLeft(MessageEntity item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonAvatar(size: 72.w),
          SizedBox(width: 20.w),
          _returnMessage(item),
        ],
      ),
    );
  }

  Widget _widgetRight(MessageEntity item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _returnMessage(item),
          SizedBox(width: 20.w),
          CommonAvatar(size: 72.w),
        ],
      ),
    );
  }

  Widget _widgetMessagePic(MessageEntity item) {
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

  Widget _widgetMessageTalk(MessageEntity item, {bool isMe = false}) {
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
          constraints: BoxConstraints(maxWidth: 506.w),
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 26.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.w),
            color: isMe ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
            // color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          child: Text(
            (item.node as TextMessageNode).content,
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
