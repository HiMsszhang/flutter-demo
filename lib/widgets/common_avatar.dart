import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:molan_edu/utils/imports.dart';

class CommonAvatar extends StatefulWidget {
  final double size;

  /// 显示性别
  final bool showSex;
  final String avatar;

  /// 性别男1女2
  final int sex;

  CommonAvatar({
    Key key,
    this.size,
    this.showSex = true,
    this.avatar = '',
    this.sex = 1,
  }) : super(key: key);

  _CommonAvatarState createState() => _CommonAvatarState();
}

class _CommonAvatarState extends State<CommonAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size ?? 100.w,
      height: widget.size ?? 100.w,
      child: Stack(
        children: [
          ClipOval(
            clipBehavior: Clip.hardEdge,
            child: widget.avatar.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.avatar,
                    fit: BoxFit.cover,
                    width: widget.size ?? 100.w,
                    height: widget.size ?? 100.w,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                      width: widget.size ?? 100.w,
                      height: widget.size ?? 100.w,
                    ),
                  )
                : Image.asset(
                    "assets/images/placeholder.png",
                    fit: BoxFit.cover,
                    width: widget.size ?? 100.w,
                    height: widget.size ?? 100.w,
                  ),
          ),
          widget.showSex ? _widgetSex() : Container(),
        ],
      ),
    );
  }

  Widget _widgetSex() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
          width: 30.w,
          height: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            color: widget.sex == 1 ? Color(0xFF90D2F8) : Color(0xFFF8BE90),
          ),
          child: Icon(
            widget.sex == 1 ? MyIcons.Iconmale : MyIcons.Iconfemale,
            size: 14.w,
            color: Colors.white,
          )),
    );
  }
}
