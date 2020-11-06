import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/card_course.dart';

class CourseSearchPage extends StatefulWidget {
  const CourseSearchPage({
    Key key,
  }) : super(key: key);

  @override
  _CourseSearchPageState createState() => _CourseSearchPageState();
}

class _CourseSearchPageState extends State<CourseSearchPage> with UtilsMixin {
  String _value = '';

  @override
  void initState() {
    super.initState();
  }

  _onTexting(String value) {
    _value = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          UnconstrainedBox(
            child: Container(
              width: 600.w,
              height: 64.w,
              child: CommonSearch(
                leading: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Icon(
                    MyIcons.Iconsearch,
                    size: 30.w,
                    color: Color(0xFFBCBCBC),
                  ),
                ),
                hintText: S.current.searchCourse,
                autofocus: true,
                onChanged: _onTexting,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              NavigatorUtils.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 34.w),
              child: Text('取消', style: Styles.normalFont(fontSize: 28.sp)),
            ),
          ),
        ],
      ),
      body: _value == ''
          ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
              child: Column(
                children: [
                  _widgetTitle(title: '搜索历史', name: 'history'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => _widgetHistory(),
                  ),
                  _widgetTitle(title: '热门搜索', name: 'hot', hasClear: false),
                  Wrap(
                    spacing: 10.w,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      7,
                      (index) => _widgetHot(),
                    ),
                  ),
                ],
              ),
            )
          : _listCourse(),
    );
  }

  Widget _widgetTitle({String title, String name, bool hasClear = true}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.w),
      child: Row(
        children: [
          Image.asset('assets/images/common/icon_search_$name.png', width: 38.w, height: 38.w, fit: BoxFit.contain),
          SizedBox(width: 18.w),
          Expanded(
            child: Text(title, style: Styles.specialFont(fontSize: 32.sp)),
          ),
          hasClear
              ? GestureDetector(
                  onTap: () {},
                  child: Text('清空', style: Styles.normalFont(fontSize: 28.sp)),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _widgetHistory() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Row(
        children: [
          Expanded(
            child: Text('1.勤礼碑一', style: Styles.normalFont(fontSize: 28.sp, color: Styles.color999999)),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.w),
              child: Image.asset('assets/images/common/icon_close.png', width: 24.w, height: 24.w, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetHot() {
    return Container(
      width: 340.w,
      padding: EdgeInsets.symmetric(vertical: 20.w),
      margin: EdgeInsets.only(bottom: 30.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            margin: EdgeInsets.only(right: 28.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Theme.of(context).accentColor,
            ),
          ),
          Text(
            '麻姑讯仙坛记一',
            style: Styles.normalFont(fontSize: 28.sp),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _listCourse() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 40.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(style: Styles.normalFont(fontSize: 28.sp, height: 1.5), children: [
              TextSpan(text: '抱歉!没有'),
              TextSpan(text: '$_value', style: Styles.normalFont(color: Color(0xFFFF9D67))),
              TextSpan(text: '相关课程\n'),
              TextSpan(text: '为您推荐以下课程', style: Styles.normalFont(color: Styles.color666666)),
            ]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 40.w),
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: CardCourse(
                width: 690.w,
                height: 378.w,
                colorType: index % 3 + 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
