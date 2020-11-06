import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/chat_list_item.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  _toDetail() {
    NavigatorUtils.pushNamed(context, '/chat.detail');
  }

  _toPerson() {
    NavigatorUtils.pushNamed(context, '/chat.person');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFF5F5F5))),
        actions: [
          UnconstrainedBox(
            child: Container(
              width: 690.w,
              height: 64.w,
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: CommonSearch(
                leading: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Icon(
                    MyIcons.Iconsearch,
                    size: 30.w,
                    color: Color(0xFFBCBCBC),
                  ),
                ),
                hintText: S.current.search,
                readOnly: true,
                onTap: () {
                  NavigatorUtils.pushNamed(context, '/chat.search');
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Container(
          width: 690.w,
          height: 0.5,
          color: Color(0xFFE6E6E6),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
        ),
        itemBuilder: (context, index) => ChatListItem(
          onTap: () {
            index == 0 ? _toDetail() : _toPerson();
          },
        ),
      ),
    );
  }
}
