import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_leaning.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({
    Key key,
  }) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> with UtilsMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [Color(0xFFFFC4A3), Color(0xFFFFABA4)],
                transform: GradientRotation(-10),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: Text(
                  '课程表',
                  style: Styles.normalFont(fontSize: 36.sp, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
                  itemCount: 10,
                  itemBuilder: (context, index) => CardLeaning(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
