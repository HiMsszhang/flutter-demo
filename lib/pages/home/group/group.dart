import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:molan_edu/widgets/card_experience.dart';
import 'package:molan_edu/widgets/card_group.dart';
import 'package:molan_edu/widgets/my_pagination.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({
    Key key,
  }) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: S.current.groupTitle,
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _widgetBanner(),
            _widgetTitle(title: S.current.experienceCourse, color: Color(0xFFCBB0FF)),
            _widgetExperience(),
            _widgetTitle(title: S.current.groupCourse, color: Color(0xFFFFC292), showMore: true),
            ...List.generate(
              6,
              (index) => Container(
                margin: EdgeInsets.only(bottom: 20.w),
                child: CardGroup(
                  width: 690.w,
                  height: 338.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetBanner() {
    return Container(
      width: 750.w,
      height: 380.w,
      child: Swiper(
        itemCount: 3,
        pagination: new SwiperCustomPagination(
          builder: (context, config) => MyPagination(length: 3, config: config),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w).copyWith(bottom: 30.w, top: 20.w),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(192, 192, 192, 0.27),
                  blurRadius: 54.w,
                )
              ],
            ),
            child: Image.asset(
              'assets/images/demo.png',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _widgetTitle({String title, Color color, bool showMore = false}) {
    return Stack(
      children: [
        Positioned(
          left: 30.w,
          bottom: 30.w,
          child: Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.49),
              borderRadius: BorderRadius.circular(38.w),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 30.w),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title ?? "",
                  style: Styles.normalFont(fontSize: 32.sp, color: Styles.colorText, fontWeight: FontWeight.bold),
                ),
              ),
              Offstage(
                offstage: !showMore,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.seeMore,
                      style: Styles.normalFont(fontSize: 26.sp, color: Styles.color999999),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 28.w,
                      color: Styles.color999999,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _widgetExperience() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          Container(
            width: 750.w,
            height: 308.w,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: CardExperience(
                  width: 513.w,
                  height: 308.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
