import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/pages/chat/chat_person.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/chat_list_item.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/entity/conversation_result_entity.dart';
import 'package:tencent_im_plugin/entity/friend_add_application_entity.dart';
import 'package:tencent_im_plugin/entity/friend_operation_result_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/enums/friend_type_enum.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with UtilsMixin {
  List<ConversationEntity> _list = [];
  int _nextSeq = 0;
  @override
  void initState() {
    super.initState();
    delayed(() async {
      await _getFriendsList();
      print(_list.toString());
    });
  }

  _toDetail() {
    NavigatorUtils.pushNamed(context, '/chat.detail');
  }

  _toPerson(ConversationEntity item) {
    NavigatorUtils.push(context, ChatPersonPage(id: item.userID, name: item.showName));
  }

  _getFriendsList() async {
    ConversationResultEntity res = await TencentImPlugin.getConversationList(nextSeq: _nextSeq);
    _list = res.conversationList;
    setState(() {});
  }

  _showAdd() {
    showDialog(
      context: context,
      builder: (context) => AddIMUser(),
    );
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAdd,
      ),
      body: ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (context, index) => Container(
          width: 690.w,
          height: 0.5,
          color: Color(0xFFE6E6E6),
          margin: EdgeInsets.symmetric(horizontal: 30.w),
        ),
        itemBuilder: (context, index) => ChatListItem(
          data: _list[index],
          onTap: () {
            _toPerson(_list[index]);
          },
        ),
      ),
    );
  }
}

class AddIMUser extends StatefulWidget {
  const AddIMUser({
    Key key,
  }) : super(key: key);

  @override
  _AddIMUserState createState() => _AddIMUserState();
}

class _AddIMUserState extends State<AddIMUser> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: TextField(
        decoration: InputDecoration(hintText: '输入要加好友的id'),
        onSubmitted: (value) async {
          try {
            List<UserEntity> res = await TencentImPlugin.getUsersInfo(userIDList: [value]);
            print(res[0].toJson());
            FriendOperationResultEntity result = await TencentImPlugin.addFriend(
              info: FriendAddApplicationEntity(
                userID: value,
                friendRemark: '',
                addWording: '',
                addSource: '',
                addType: FriendTypeEnum.Both,
              ),
            );
            print(result.resultCode);
          } catch (e) {
            print('err');
            print(e);
          } finally {
            print('ff');
          }
        },
      ),
    );
  }
}
