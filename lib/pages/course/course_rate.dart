import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_rate.dart';

class CourseRatePage extends StatefulWidget {
  const CourseRatePage({
    Key key,
  }) : super(key: key);

  @override
  _CourseRatePageState createState() => _CourseRatePageState();
}

class _CourseRatePageState extends State<CourseRatePage> with UtilsMixin {
  int _selectedIndex = 0;

  _onOptionsTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '学员评价',
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
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
                          Text('学员评价', style: Styles.specialFont(fontSize: 32.sp)),
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
              margin: EdgeInsets.symmetric(vertical: 14.w),
              clipBehavior: Clip.hardEdge,
              decoration: Styles.normalDecoration.copyWith(
                borderRadius: BorderRadius.circular(16.w),
                color: Theme.of(context).primaryColor,
              ),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => CardRate(),
                separatorBuilder: (context, index) => Container(
                  width: 636.w,
                  height: 1,
                  color: Color(0xFFF6F6F7),
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
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
