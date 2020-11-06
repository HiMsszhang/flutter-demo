import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_all_course.dart';
import 'package:molan_edu/widgets/card_mine_teacher.dart';
import 'package:molan_edu/widgets/card_share.dart';
import 'package:molan_edu/widgets/rate_list.dart';

class TeacherInfoPage extends StatefulWidget {
  const TeacherInfoPage({
    Key key,
  }) : super(key: key);

  @override
  _TeacherInfoPageState createState() => _TeacherInfoPageState();
}

class _TeacherInfoPageState extends State<TeacherInfoPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  _toAllCourse() {
    NavigatorUtils.pushNamed(context, '/teacher.course');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 525.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(400.w, 34.w)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [Color(0xFFFFCAAD), Color(0xFFFFA7A3)],
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                brightness: Brightness.dark,
                title: Text(
                  'Vicky老师的主页',
                  style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 33.w,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 40.w),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          CardMineTeacher(showTags: true),
                          Container(
                            width: 690.w,
                            height: 109.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: Styles.normalDecoration.copyWith(
                              borderRadius: BorderRadius.circular(16.w),
                            ),
                            margin: EdgeInsets.only(bottom: 14.w),
                            child: RawMaterialButton(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              onPressed: () {
                                _toAllCourse();
                              },
                              child: Row(
                                children: [
                                  Image.asset('assets/images/course/icon_course.png', width: 30.w, height: 30.w),
                                  SizedBox(width: 18.w),
                                  Expanded(
                                    child: Text('全部课程.22', style: Styles.specialFont(fontSize: 32.sp)),
                                  ),
                                  Text('查看更多', style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999)),
                                  SizedBox(width: 10.w),
                                  Icon(Icons.arrow_forward_ios, size: 23.w, color: Styles.color999999),
                                ],
                              ),
                            ),
                          ),
                          CardAllCourse(),
                          CardAllCourse(),
                          RateList(),
                          SizedBox(height: 20.w),
                          Container(
                            width: 690.w,
                            height: 109.w,
                            clipBehavior: Clip.hardEdge,
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            decoration: Styles.normalDecoration.copyWith(
                              borderRadius: BorderRadius.circular(16.w),
                            ),
                            child: Row(
                              children: [
                                ImageIcon(
                                  AssetImage('assets/images/common/icon_share.png'),
                                  size: 30.w,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(width: 18.w),
                                Expanded(
                                  child: Text('Vicky老师的分享', style: Styles.specialFont(fontSize: 32.sp)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.w),
                    CardShare(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
