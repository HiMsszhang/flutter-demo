import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_chat.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '墨岚消息',
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    height: 92.w,
                    alignment: Alignment.center,
                    child: Text('2020-11-22  下午2点', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                  ),
                  CardChat(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
