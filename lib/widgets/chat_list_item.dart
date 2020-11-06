import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';

class ChatListItem extends StatefulWidget {
  final VoidCallback onTap;
  ChatListItem({
    Key key,
    this.onTap,
  }) : super(key: key);

  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
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
                  ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset('assets/images/demo.png', width: 80.w, height: 80.w, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 0,
                    right: 4.w,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: Styles.colorRed,
                        borderRadius: BorderRadius.circular(16.w),
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
                      Text('官方客服', style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorText, fontWeight: FontWeight.bold)),
                      Text('昨天', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color999999)),
                    ],
                  ),
                  SizedBox(height: 16.w),
                  Text('[行书]勤礼碑一系列', style: Styles.normalFont(fontSize: 22.sp, color: Styles.color999999)),
                  Padding(
                    padding: EdgeInsets.only(top: 24.w),
                    child: Text('[1条]你好，我是你的班主任。', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color666666)),
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
