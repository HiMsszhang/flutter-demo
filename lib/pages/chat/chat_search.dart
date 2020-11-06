import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/chat_list_item.dart';

class ChatSearchPage extends StatefulWidget {
  const ChatSearchPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatSearchPageState createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '',
      actions: [
        UnconstrainedBox(
          child: Container(
            width: 600.w,
            height: 64.w,
            child: CommonSearch(
              leading: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Icon(
                  MyIcons.Iconsearch,
                  size: 30.w,
                  color: Color(0xFFBCBCBC),
                ),
              ),
              hintText: S.current.searchCourse,
              autofocus: true,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            NavigatorUtils.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: Text('取消', style: Styles.normalFont(fontSize: 28.sp)),
          ),
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 110.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Color(0xFFE6E6E6))),
            ),
            child: Text(
              '联系人',
              style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
          ),
          ChatListItem(),
          Container(
            height: 110.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Color(0xFFE6E6E6))),
            ),
            child: Text(
              '聊天记录',
              style: Styles.normalFont(fontSize: 32.sp, fontWeight: FontWeight.bold),
            ),
          ),
          ChatListItem(),
        ],
      ),
    );
  }
}
