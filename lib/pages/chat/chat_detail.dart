import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/date_dart/main.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_chat.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class ChatDetailPage extends StatefulWidget {
  final String id;
  final String name;
  const ChatDetailPage({
    Key key,
    this.id,
    this.name,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with UtilsMixin {
  /// 消息列表
  List<MessageEntity> _list = [];

  @override
  void initState() {
    super.initState();
    TencentImPlugin.addListener(_imListener);
    delayed(() async {
      await _setRead();
      await _getData();
    });
  }

  @override
  void dispose() {
    TencentImPlugin.removeListener(_imListener);
    super.dispose();
  }

  /// IM监听器
  _imListener(type, params) {
    if (type == TencentImListenerTypeEnum.NewMessage) {
      setState(() {
        _list.insert(0, params);
      });
    }
  }

  _setRead() async {
    await TencentImPlugin.markC2CMessageAsRead(userID: widget.id);
  }

  _getData() async {
    _list = await TencentImPlugin.getC2CHistoryMessageList(userID: widget.id, count: 50);
    for (var item in _list) {
      print(item.toJson());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: widget.name ?? "",
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: _list.length,
              itemBuilder: (context, index) {
                var item = (_list[index].node as TextMessageNode).content;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 92.w,
                      alignment: Alignment.center,
                      child: Text(DateDart.formatTimestamp(_list[index].timestamp * 1000, 'yyyy-MM-dd HH:mm:ss') ?? '', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    ),
                    CardChat(data: jsonDecode(item)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
