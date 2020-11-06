import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyPagination extends StatefulWidget {
  final SwiperPluginConfig config;
  final int length;
  final Alignment alignment;
  MyPagination({
    Key key,
    this.config,
    this.length = 0,
    this.alignment,
  }) : super(key: key);

  _MyPaginationState createState() => _MyPaginationState();
}

class _MyPaginationState extends State<MyPagination> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment ?? Alignment(0, 0.95),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.length,
          (index) => widget.config.activeIndex == index
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 16.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                )
              : AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 8.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                ),
        ),
      ),
    );
  }
}
