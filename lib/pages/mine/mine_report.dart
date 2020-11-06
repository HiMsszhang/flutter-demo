import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/card_report.dart';

class MineReportPage extends StatefulWidget {
  const MineReportPage({
    Key key,
  }) : super(key: key);

  @override
  _MineReportPageState createState() => _MineReportPageState();
}

class _MineReportPageState extends State<MineReportPage> with UtilsMixin {
  bool _isFilterShow = false;
  @override
  void initState() {
    super.initState();
  }

  _showFilter() {
    setState(() {
      _isFilterShow = true;
    });
    // Navigator.push(
    //   context,
    //   PageRouteBuilder(
    //     transitionsBuilder: (_, animation, __, child) => overlayTransitionsBuilder(_, animation, __, child, begin: Offset(0, -1)),
    //     opaque: false,
    //     pageBuilder: (context, animation, secondaryAnimation) {
    //       return FilterOverlay();
    //     },
    //   ),
    // );
  }

  _hideFilter() {
    setState(() {
      _isFilterShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppbar(
      actionTitle: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('勤礼碑一系列', style: Styles.normalFont(fontSize: 36.sp, fontWeight: FontWeight.bold)),
            Transform.rotate(
              angle: pi / 2,
              child: Icon(Icons.play_arrow, size: 34.w, color: Styles.color999999),
            ),
          ],
        ),
        onTap: () {
          _showFilter();
        },
      ),
      actions: [
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/mine/icon_mine_report.png'),
            size: 33.w,
          ),
          onPressed: () {
            NavigatorUtils.pushNamed(context, '/mine.report.detail');
          },
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.w),
            itemCount: 6,
            itemBuilder: (context, index) => CardReport(),
          ),
          _isFilterShow
              ? Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      _hideFilter();
                    },
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  ),
                )
              : Container(),
          filterOverlay(),
        ],
      ),
    );
  }

  Widget filterOverlay() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.w)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 750.w,
        height: _isFilterShow ? 600.w : 0,
        padding: EdgeInsets.symmetric(vertical: 20.w),
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: Text('多宝塔一系列', style: Styles.normalFont(fontSize: 30.sp, color: Styles.color666666)),
            onPressed: () {
              _hideFilter();
            },
          ),
          itemCount: 10,
        ),
      ),
    );
  }
}
