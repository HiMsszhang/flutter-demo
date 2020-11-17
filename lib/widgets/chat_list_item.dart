import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:molan_edu/utils/date_dart/main.dart';

class ChatListItem extends StatefulWidget {
  final VoidCallback onTap;
  final ConversationEntity data;
  ChatListItem({
    Key key,
    this.onTap,
    this.data,
  }) : super(key: key);

  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> with UtilsMixin {
  _showText() {
    var result = '';
    switch (widget.data.lastMessage.elemType) {
      case MessageElemTypeEnum.None:
        result = '';
        break;
      case MessageElemTypeEnum.Text:
        result = (widget.data.lastMessage.node as TextMessageNode).content;
        break;
      case MessageElemTypeEnum.File:
        result = '[文件]';
        break;
      case MessageElemTypeEnum.Image:
        result = '[图片]';
        break;
      default:
        result = '[自定义消息]';
        break;
    }
    return result;
  }

  _showCount() {
    var count = widget.data.unreadCount;
    var result = '';
    if (count == 0) {
      result = '';
    } else {
      result = '[$count条]';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 30.w),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              margin: EdgeInsets.only(right: 30.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.w),
              ),
              child: Stack(
                children: [
                  CommonAvatar(
                    size: 80.w,
                    showSex: false,
                    avatar: widget.data.faceUrl ?? '',
                  ),
                  Positioned(
                    top: 0,
                    right: 4.w,
                    child: Offstage(
                      offstage: widget.data.unreadCount == 0,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          color: Styles.colorRed,
                          borderRadius: BorderRadius.circular(16.w),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.data.showName ?? '', style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorText, fontWeight: FontWeight.bold)),
                      Text(DateDart.formatTimestamp(widget.data.lastMessage.timestamp * 1000, 'MM-dd HH:mm') ?? '', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    ],
                  ),
                  SizedBox(height: 16.w),
                  // Text('[行书]勤礼碑一系列', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                  Padding(
                    padding: EdgeInsets.only(top: 24.w),
                    child: Text('${_showCount()}${_showText()}', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
