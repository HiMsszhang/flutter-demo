import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_timetable.dart';

class TimetableListPage extends StatefulWidget {
  const TimetableListPage({
    Key key,
  }) : super(key: key);

  @override
  _TimetableListPageState createState() => _TimetableListPageState();
}

class _TimetableListPageState extends State<TimetableListPage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      title: '【楷书】勤礼碑一系列',
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
        itemCount: 10,
        itemBuilder: (context, index) => CardTimetable(
          isLock: index > 1,
          onTap: () {
            NavigatorUtils.pushNamed(context, '/timetable.detail');
          },
        ),
      ),
    );
  }
}
