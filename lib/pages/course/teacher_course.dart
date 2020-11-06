import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:molan_edu/widgets/card_all_course.dart';

class TeacherCoursePage extends StatefulWidget {
  const TeacherCoursePage({
    Key key,
  }) : super(key: key);

  @override
  _TeacherCoursePageState createState() => _TeacherCoursePageState();
}

class _TeacherCoursePageState extends State<TeacherCoursePage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '全部课程',
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
        itemCount: 10,
        itemBuilder: (context, index) => CardAllCourse(),
      ),
    );
  }
}
