import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/pages/chat/chat_person.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/chat_list_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/entity/conversation_result_entity.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:molan_edu/providers/user_state.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with UtilsMixin, AutomaticKeepAliveClientMixin<ChatPage> {
  @override
  bool get wantKeepAlive => false;

  List<ConversationEntity> _list = [];
  List<ConversationEntity> _searchList = [];
  String _searchWord = '';
  int _nextSeq = 0;
  bool hasLogin = false;
  RefreshController _listController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    TencentImPlugin.addListener(_imListener);
    delayed(() async {
      hasLogin = context.read<UserState>().hasLogin;
      if (hasLogin) _listController.requestRefresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    TencentImPlugin.removeListener(_imListener);
  }

  void _onRefresh() async {
    _nextSeq = 0;
    _list = await _getList();
    setState(() {});
    _listController.refreshCompleted();
  }

  void _onLoading() async {
    _list.addAll(await _getList());
    _listController.loadComplete();
    if (mounted) setState(() {});
  }

  /// IM监听器
  _imListener(type, params) async {
    print(type);
    if (type == TencentImListenerTypeEnum.ConversationChanged) {
      List<ConversationEntity> change = params;
      for (var i = 0; i < _list.length; i++) {
        var item = _list[i];
        for (var changeItem in change) {
          if (item.conversationID == changeItem.conversationID) {
            _list[i] = changeItem;
          }
        }
      }
      setState(() {});
    }
  }

  _onSearch(String value) {
    var list = _list;
    _searchWord = value;
    for (var item in list) {
      if (item.showName.contains(value)) {
        _searchList.add(item);
      }
    }
    setState(() {});
  }

  _toDetail() {
    NavigatorUtils.pushNamed(context, '/chat.detail');
  }

  _toPerson(ConversationEntity item) {
    NavigatorUtils.push(context, ChatPersonPage(id: item.userID, name: item.showName));
  }

  Future<List<ConversationEntity>> _getList() async {
    ConversationResultEntity res = await TencentImPlugin.getConversationList(nextSeq: _nextSeq);
    _nextSeq = res.nextSeq;
    setState(() {});
    return res.conversationList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                inputText: _searchWord,
                hintText: S.current.search,
                onSubmitted: _onSearch,
                onClear: () {
                  setState(() {
                    _searchWord = "";
                  });
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _searchWord.isEmpty
          ? SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _listController,
              header: myCustomHeader(),
              footer: myCustomFooter(),
              child: ListView(
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                ],
              ),
            )
          : ListView.separated(
              itemCount: _searchList.length ?? 0,
              separatorBuilder: (context, index) => Container(
                width: 690.w,
                height: 0.5,
                color: Color(0xFFE6E6E6),
                margin: EdgeInsets.symmetric(horizontal: 30.w),
              ),
              itemBuilder: (context, index) => ChatListItem(
                data: _searchList[index],
                onTap: () {
                  _toPerson(_searchList[index]);
                },
              ),
            ),
    );
  }
}
