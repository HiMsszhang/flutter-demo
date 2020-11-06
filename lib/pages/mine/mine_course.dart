import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_search.dart';
import 'package:molan_edu/widgets/card_mine_course.dart';

class MineCoursePage extends StatefulWidget {
  const MineCoursePage({
    Key key,
  }) : super(key: key);

  @override
  _MineCoursePageState createState() => _MineCoursePageState();
}

class _MineCoursePageState extends State<MineCoursePage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      backgroundColor: Theme.of(context).primaryColor,
      title: '',
      actions: [
        UnconstrainedBox(
          child: Container(
            width: 623.w,
            height: 64.w,
            margin: EdgeInsets.only(right: 16.w),
            child: CommonSearch(
              leading: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Icon(
                  MyIcons.Iconsearch,
                  size: 30.w,
                  color: Color(0xFFBCBCBC),
                ),
              ),
              hintText: '搜索已购课程名称',
            ),
          ),
        ),
      ],
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
        itemCount: 10,
        itemBuilder: (context, index) => CardMineCourse(showTags: true),
      ),
    );
  }
}
