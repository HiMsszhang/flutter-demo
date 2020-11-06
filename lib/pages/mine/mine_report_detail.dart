import 'package:flutter/material.dart';
import 'package:molan_edu/mixins/utils_mixin.dart';
import 'package:molan_edu/utils/imports.dart';

import 'package:molan_edu/widgets/common_avatar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:molan_edu/widgets/growth_report_sharing.dart';

class MineReportDetailPage extends StatefulWidget {
  const MineReportDetailPage({
    Key key,
  }) : super(key: key);

  @override
  _MineReportDetailPageState createState() => _MineReportDetailPageState();
}

class _MineReportDetailPageState extends State<MineReportDetailPage> with UtilsMixin {
  List<Map> _labelList = [
    {'title': '累计学习时长', 'label': '小时'},
    {'title': '已学习课程', 'label': '节'},
    {'title': '掌握书法字数', 'label': '个'},
    {'title': '完成作业次数', 'label': '次'},
    {'title': '当前星星数', 'label': '颗'},
    {'title': '表现优秀次数', 'label': '次'},
  ];

  List<Color> chartColors = [
    const Color(0xFFFFA06B),
    const Color(0xFF7CC3FF),
  ];

  @override
  void initState() {
    super.initState();
  }

  _showShare() {
    growthreportSharing(context);
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
                colors: [Color(0xFFFF9789), Color(0xFFFDC3A3)],
                transform: GradientRotation(147),
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
                title: Text(
                  '公爵大人的成长分析报告',
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
                actions: [
                  IconButton(
                    icon: ImageIcon(
                      AssetImage('assets/images/common/icon_share.png'),
                      size: 33.w,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showShare();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 40.w,
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(38.w, 19.w, 30.w, 13.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Row(
                        children: [
                          CommonAvatar(
                            size: 102.w,
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('公爵大人', style: Styles.normalFont(fontSize: 30.sp, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20.w),
                              Text('10岁', style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _widgetChain(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Wrap(
                        runSpacing: 55.w,
                        spacing: 0,
                        children: List.generate(
                          _labelList.length,
                          (index) => Container(
                            width: 230.w,
                            child: Column(
                              children: [
                                Text(_labelList[index]['title'], style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                                SizedBox(height: 16.w),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('288', style: Styles.normalFont(fontSize: 40.sp, color: Color(0xFFFF835F), fontWeight: FontWeight.bold)),
                                    Text(_labelList[index]['label'], style: Styles.normalFont(fontSize: 24.sp, color: Styles.color666666)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _widgetChain(),
                    _widgetChart(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetChart() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36.w, horizontal: 30.w).copyWith(bottom: 100.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.w)),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/mine/icon_homework.png', width: 40.w, height: 40.w),
              SizedBox(width: 17.w),
              Expanded(
                child: Text('作业表现', style: Styles.normalFont(fontSize: 30.w, fontWeight: FontWeight.bold, height: 1.2)),
              ),
              Container(
                width: 18.w,
                height: 18.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.w),
                  color: chartColors[0],
                ),
              ),
              Text('优', style: Styles.normalFont(fontSize: 28.sp, color: chartColors[0], fontWeight: FontWeight.bold)),
              SizedBox(width: 104.w),
              Container(
                width: 18.w,
                height: 18.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.w),
                  color: chartColors[1],
                ),
              ),
              Text('良', style: Styles.normalFont(fontSize: 28.sp, color: chartColors[1], fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 60.w),
          AspectRatio(
            aspectRatio: 548 / 249,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetChain() {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: 28.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.w)),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20.w),
              Container(
                width: double.infinity,
                height: 28.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 30.w,
            child: Image.asset('assets/images/mine/pic_report_chain.png', width: 52.w, height: 76.w),
          ),
          Positioned(
            top: 0,
            right: 30.w,
            child: Image.asset('assets/images/mine/pic_report_chain.png', width: 52.w, height: 76.w),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2)),
          left: BorderSide(width: 1, color: Color(0xFFF2F2F2)),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xffF2F2F2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 0,
          rotateAngle: 70,
          getTextStyles: (value) => TextStyle(color: Styles.color666666, fontSize: 22.sp),
          getTitles: (value) {
            var res = value.toInt().toString();
            return '第$res节';
          },
          margin: 22.w,
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      minX: 1,
      maxX: 10,
      minY: 0,
      maxY: 2,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, 1),
            FlSpot(2, 1),
            FlSpot(3, 2),
            FlSpot(4, 1),
            FlSpot(5, 2),
            FlSpot(6, 2),
            FlSpot(7, 1),
            FlSpot(8, 1),
            FlSpot(9, 1),
            FlSpot(10, 2),
          ],
          colors: [chartColors[0], chartColors[0]],
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (value, _, __, ___) {
              var color = value.y == 1 ? chartColors[1] : chartColors[0];
              return FlDotCirclePainter(
                color: color,
                strokeWidth: 0,
                radius: 9.w,
              );
            },
          ),
        ),
      ],
    );
  }
}
