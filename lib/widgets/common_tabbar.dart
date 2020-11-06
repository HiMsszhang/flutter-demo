import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:molan_edu/styles.dart';

class CommonTabbar extends StatefulWidget {
  final TabController controller;
  final List<String> itemList;
  final Function onChanged;
  final bool isCenter;

  /// 特殊字体
  final bool isSpecial;

  CommonTabbar({
    Key key,
    this.controller,
    this.itemList,
    this.onChanged,
    this.isCenter = false,
    this.isSpecial = false,
  }) : super(key: key);

  _CommonTabbarState createState() => _CommonTabbarState();
}

class _CommonTabbarState extends State<CommonTabbar> {
  int _selectedIndex = 0;

  _onChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.isCenter ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
      children: List.generate(
        widget.itemList.length,
        (index) => InkWell(
          onTap: () {
            _onChange(index);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    widget.itemList[index],
                    style: widget.isSpecial
                        ? _selectedIndex == index
                            ? Styles.specialFont(fontSize: 36.sp, color: Styles.colorText, fontWeight: FontWeight.bold)
                            : Styles.specialFont(fontSize: 30.sp, color: Styles.colorInfo)
                        : _selectedIndex == index
                            ? Styles.normalFont(fontSize: 36.sp, color: Styles.colorText, fontWeight: FontWeight.bold)
                            : Styles.normalFont(fontSize: 30.sp, color: Styles.colorInfo),
                  ),
                ),
                Positioned.fill(
                  bottom: 10.w,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      widthFactor: .4,
                      child: Container(
                        width: double.infinity,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: _selectedIndex == index ? Theme.of(context).accentColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
