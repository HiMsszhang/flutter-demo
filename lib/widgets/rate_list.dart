import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/card_rate.dart';

class RateList extends StatefulWidget {
  final bool isList;
  final int listLength;

  RateList({
    Key key,
    this.isList = false,
    this.listLength = 2,
  }) : super(key: key);

  _RateListState createState() => _RateListState();
}

class _RateListState extends State<RateList> {
  int _selectedIndex = 0;

  _onOptionsTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14.w),
      child: Column(
        children: [
          Container(
            width: 690.w,
            padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 40.w),
            decoration: Styles.normalDecoration.copyWith(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Image.asset('assets/images/common/icon_edit.png', width: 34.w, height: 31.w),
                        SizedBox(width: 17.w),
                        Text('学员评价', style: Styles.normalFont(fontSize: 32.sp)),
                        SizedBox(width: 6.w),
                        Text('（17个评价）', style: Styles.normalFont(fontSize: 24.sp)),
                      ],
                    ),
                    Text('学生喜爱度:99.5%', style: Styles.specialFont(fontSize: 30.sp, color: Theme.of(context).accentColor)),
                  ],
                ),
                SizedBox(height: 30.w),
                _widgetOptions(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14.w),
            clipBehavior: Clip.hardEdge,
            decoration: Styles.normalDecoration.copyWith(
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Container(
              width: 690.w,
              child: Column(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CardRate(),
                    separatorBuilder: (context, index) => Container(
                      width: 636.w,
                      height: 1,
                      color: Color(0xFFF6F6F7),
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                    ),
                    itemCount: widget.listLength,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigatorUtils.pushNamed(context, '/course.rate');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.w),
                          margin: EdgeInsets.symmetric(vertical: 30.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48.w),
                            color: Color(0xFFF5F5F5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Text('查看更多学员评价', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999)),
                              SizedBox(width: 10.w),
                              Transform.rotate(
                                angle: -pi / 2,
                                child: Icon(Icons.arrow_back_ios, size: 22.w, color: Styles.color999999),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetOptions() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 13.w,
      runSpacing: 22.w,
      children: List.generate(
        7,
        (index) => InkWell(
          onTap: () {
            _onOptionsTap(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 11.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.w),
              color: _selectedIndex == index ? Theme.of(context).accentColor : Color(0xFFF5F5F5),
            ),
            child: Text(
              '生动有趣x2',
              style: Styles.normalFont(fontSize: 26.sp, color: _selectedIndex == index ? Colors.white : Styles.color999999),
            ),
          ),
        ),
      ),
    );
  }
}
