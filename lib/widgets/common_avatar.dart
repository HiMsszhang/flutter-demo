import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:molan_edu/utils/imports.dart';

class CommonAvatar extends StatefulWidget {
  final double size;

  /// 显示性别
  final bool showSex;
  final String avatar;

  CommonAvatar({
    Key key,
    this.size,
    this.showSex = true,
    this.avatar = '',
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
          widget.showSex ? _widgetBoy() : Container(),
        ],
      ),
    );
  }

  Widget _widgetBoy() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
          width: 30.w,
          height: 30.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            color: Color(0xFF90D2F8),
          ),
          child: Image.asset('assets/images/common/sex_male.png', width: 17.w, height: 17.w)),
    );
  }
}
